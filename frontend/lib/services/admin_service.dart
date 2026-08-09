import 'dart:math';
import '../models/admin_model.dart';
import '../models/password_reset_token_model.dart';
import 'auth_service.dart';
import 'storage_service.dart';

class AdminAuthResult {
  final AuthStatus status;
  final String message;
  final AdminModel? admin;
  final String? resetCode;

  const AdminAuthResult({
    required this.status,
    required this.message,
    this.admin,
    this.resetCode,
  });
}

class AdminService {
  final StorageService _storageService;

  AdminService({StorageService? storageService})
      : _storageService = storageService ?? StorageService();

  // Admin Login
  Future<AdminAuthResult> login({
    required String email,
    required String password,
  }) async {
    try {
      final normalizedEmail = email.trim().toLowerCase();
      final admin = await _storageService.getAdminByEmail(normalizedEmail);

      if (admin == null) {
        return const AdminAuthResult(
          status: AuthStatus.noAccountFound,
          message: 'No admin account found with this email.',
        );
      }

      if (admin.password == password.trim()) {
        await _storageService.saveLoggedInAdmin(admin);
        return AdminAuthResult(
          status: AuthStatus.success,
          message: 'Admin login successful!',
          admin: admin,
        );
      } else {
        return const AdminAuthResult(
          status: AuthStatus.invalidCredentials,
          message: 'Invalid Admin ID or password.',
        );
      }
    } catch (e) {
      return AdminAuthResult(
        status: AuthStatus.error,
        message: 'Admin login failed: ${e.toString()}',
      );
    }
  }

  // Request admin password reset
  Future<AdminAuthResult> requestPasswordReset(String email) async {
    try {
      final normalizedEmail = email.trim().toLowerCase();
      final admin = await _storageService.getAdminByEmail(normalizedEmail);

      if (admin == null) {
        return const AdminAuthResult(
          status: AuthStatus.noAccountFound,
          message: 'No admin account found with this email.',
        );
      }

      // Generate a secure 6-digit reset code
      final random = Random.secure();
      final code = (100000 + random.nextInt(900000)).toString();

      final resetToken = PasswordResetToken(
        email: normalizedEmail,
        token: code,
        expiresAt: DateTime.now().add(const Duration(minutes: 15)),
        accountType: 'admin',
      );

      await _storageService.saveResetToken(resetToken);

      return AdminAuthResult(
        status: AuthStatus.success,
        message: 'Password reset instructions have been sent to your email.',
        resetCode: code,
      );
    } catch (e) {
      return AdminAuthResult(
        status: AuthStatus.error,
        message: 'Failed to process admin reset request: ${e.toString()}',
      );
    }
  }

  // Verify admin reset token
  Future<AdminAuthResult> verifyResetToken({
    required String email,
    required String token,
  }) async {
    try {
      final normalizedEmail = email.trim().toLowerCase();
      final savedToken = await _storageService.getResetToken(normalizedEmail);

      if (savedToken == null || savedToken.token != token.trim()) {
        return const AdminAuthResult(
          status: AuthStatus.invalidToken,
          message: 'Invalid verification code. Please check and try again.',
        );
      }

      if (savedToken.isExpired) {
        return const AdminAuthResult(
          status: AuthStatus.tokenExpired,
          message: 'Verification code has expired. Please request a new one.',
        );
      }

      return const AdminAuthResult(
        status: AuthStatus.success,
        message: 'Code verified successfully.',
      );
    } catch (e) {
      return AdminAuthResult(
        status: AuthStatus.error,
        message: 'Verification failed: ${e.toString()}',
      );
    }
  }

  // Reset admin password with token
  Future<AdminAuthResult> resetPassword({
    required String email,
    required String token,
    required String newPassword,
  }) async {
    try {
      final normalizedEmail = email.trim().toLowerCase();
      final verifyResult = await verifyResetToken(
        email: normalizedEmail,
        token: token,
      );

      if (verifyResult.status != AuthStatus.success) {
        return verifyResult;
      }

      final updated = await _storageService.updateAdminPassword(
        normalizedEmail,
        newPassword.trim(),
      );

      if (!updated) {
        return const AdminAuthResult(
          status: AuthStatus.noAccountFound,
          message: 'No admin account found with this email.',
        );
      }

      await _storageService.clearResetToken(normalizedEmail);

      return const AdminAuthResult(
        status: AuthStatus.success,
        message: 'Password reset successfully! Please login with your new password.',
      );
    } catch (e) {
      return AdminAuthResult(
        status: AuthStatus.error,
        message: 'Admin password reset failed: ${e.toString()}',
      );
    }
  }

  // Get currently logged-in admin
  Future<AdminModel?> getCurrentAdmin() async {
    return await _storageService.getLoggedInAdmin();
  }

  // Logout admin
  Future<void> logout() async {
    await _storageService.clearLoggedInAdmin();
  }
}
