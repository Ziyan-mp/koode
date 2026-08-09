import 'dart:math';
import '../models/password_reset_token_model.dart';
import '../models/user_model.dart';
import 'storage_service.dart';

enum AuthStatus {
  success,
  noAccountFound,
  invalidCredentials,
  emailAlreadyExists,
  invalidToken,
  tokenExpired,
  error,
}

class AuthResult {
  final AuthStatus status;
  final String message;
  final UserModel? user;
  final String? resetCode;

  const AuthResult({
    required this.status,
    required this.message,
    this.user,
    this.resetCode,
  });
}

class AuthService {
  final StorageService _storageService;

  AuthService({StorageService? storageService})
      : _storageService = storageService ?? StorageService();

  // Register a new user
  Future<AuthResult> register(UserModel user) async {
    try {
      final existingUser = await _storageService.getUserByEmail(user.email);
      if (existingUser != null) {
        return const AuthResult(
          status: AuthStatus.emailAlreadyExists,
          message: 'An account with this email already exists.',
        );
      }

      await _storageService.saveUser(user);
      await _storageService.saveLoggedInUser(user);

      return AuthResult(
        status: AuthStatus.success,
        message: 'Registration successful!',
        user: user,
      );
    } catch (e) {
      return AuthResult(
        status: AuthStatus.error,
        message: 'Registration failed: ${e.toString()}',
      );
    }
  }

  // Authenticate an existing user
  Future<AuthResult> login({
    required String email,
    required String password,
  }) async {
    try {
      final hasUsers = await _storageService.hasRegisteredUsers();
      if (!hasUsers) {
        return const AuthResult(
          status: AuthStatus.noAccountFound,
          message: 'No account found. Please register first.',
        );
      }

      final normalizedEmail = email.trim().toLowerCase();
      final user = await _storageService.getUserByEmail(normalizedEmail);

      if (user == null) {
        return const AuthResult(
          status: AuthStatus.invalidCredentials,
          message: 'Invalid email or password.',
        );
      }

      if (user.password == password.trim()) {
        await _storageService.saveLoggedInUser(user);
        return AuthResult(
          status: AuthStatus.success,
          message: 'Login successful!',
          user: user,
        );
      } else {
        return const AuthResult(
          status: AuthStatus.invalidCredentials,
          message: 'Invalid email or password.',
        );
      }
    } catch (e) {
      return AuthResult(
        status: AuthStatus.error,
        message: 'Login failed: ${e.toString()}',
      );
    }
  }

  // Request password reset link / code
  Future<AuthResult> requestPasswordReset(String email) async {
    try {
      final normalizedEmail = email.trim().toLowerCase();
      final user = await _storageService.getUserByEmail(normalizedEmail);

      if (user == null) {
        return const AuthResult(
          status: AuthStatus.noAccountFound,
          message: 'No account found with this email.',
        );
      }

      // Generate a secure 6-digit reset code
      final random = Random.secure();
      final code = (100000 + random.nextInt(900000)).toString();

      final resetToken = PasswordResetToken(
        email: normalizedEmail,
        token: code,
        expiresAt: DateTime.now().add(const Duration(minutes: 15)),
        accountType: 'user',
      );

      await _storageService.saveResetToken(resetToken);

      return AuthResult(
        status: AuthStatus.success,
        message: 'Password reset instructions have been sent to your email.',
        resetCode: code,
      );
    } catch (e) {
      return AuthResult(
        status: AuthStatus.error,
        message: 'Failed to process request: ${e.toString()}',
      );
    }
  }

  // Verify reset token
  Future<AuthResult> verifyResetToken({
    required String email,
    required String token,
  }) async {
    try {
      final normalizedEmail = email.trim().toLowerCase();
      final savedToken = await _storageService.getResetToken(normalizedEmail);

      if (savedToken == null || savedToken.token != token.trim()) {
        return const AuthResult(
          status: AuthStatus.invalidToken,
          message: 'Invalid verification code. Please check and try again.',
        );
      }

      if (savedToken.isExpired) {
        return const AuthResult(
          status: AuthStatus.tokenExpired,
          message: 'Verification code has expired. Please request a new one.',
        );
      }

      return const AuthResult(
        status: AuthStatus.success,
        message: 'Code verified successfully.',
      );
    } catch (e) {
      return AuthResult(
        status: AuthStatus.error,
        message: 'Verification failed: ${e.toString()}',
      );
    }
  }

  // Reset user password with token
  Future<AuthResult> resetPassword({
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

      final updated = await _storageService.updateUserPassword(
        normalizedEmail,
        newPassword.trim(),
      );

      if (!updated) {
        return const AuthResult(
          status: AuthStatus.noAccountFound,
          message: 'No account found with this email.',
        );
      }

      await _storageService.clearResetToken(normalizedEmail);

      return const AuthResult(
        status: AuthStatus.success,
        message: 'Password reset successfully! Please login with your new password.',
      );
    } catch (e) {
      return AuthResult(
        status: AuthStatus.error,
        message: 'Password reset failed: ${e.toString()}',
      );
    }
  }

  // Get currently authenticated user session
  Future<UserModel?> getCurrentUser() async {
    return await _storageService.getLoggedInUser();
  }

  // Logout current user
  Future<void> logout() async {
    await _storageService.clearLoggedInUser();
  }
}
