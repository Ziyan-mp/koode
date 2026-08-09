import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:frontend/models/user_model.dart';
import 'package:frontend/services/auth_service.dart';
import 'package:frontend/services/admin_service.dart';
import 'package:frontend/services/storage_service.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  group('User Forgot Password & Reset Tests', () {
    late AuthService authService;
    late StorageService storageService;

    setUp(() {
      storageService = StorageService();
      authService = AuthService(storageService: storageService);
    });

    test('Requesting reset for unregistered user returns noAccountFound', () async {
      final result = await authService.requestPasswordReset('unregistered@campus.edu');
      expect(result.status, AuthStatus.noAccountFound);
      expect(result.message, 'No account found with this email.');
    });

    test('Complete User Forgot Password and Reset flow', () async {
      // 1. Register a user
      final user = UserModel(
        fullName: 'Test Student',
        email: 'student@campus.edu',
        password: 'OriginalPassword123',
        department: 'Computer Science',
      );
      final regResult = await authService.register(user);
      expect(regResult.status, AuthStatus.success);

      // 2. Request Password Reset
      final resetReqResult = await authService.requestPasswordReset('student@campus.edu');
      expect(resetReqResult.status, AuthStatus.success);
      expect(
        resetReqResult.message,
        'Password reset instructions have been sent to your email.',
      );
      expect(resetReqResult.resetCode, isNotNull);
      final token = resetReqResult.resetCode!;

      // 3. Attempt reset with invalid token
      final invalidTokenResult = await authService.resetPassword(
        email: 'student@campus.edu',
        token: '999999',
        newPassword: 'NewPassword456',
      );
      expect(invalidTokenResult.status, AuthStatus.invalidToken);

      // 4. Reset with valid token
      final resetSuccessResult = await authService.resetPassword(
        email: 'student@campus.edu',
        token: token,
        newPassword: 'NewPassword456',
      );
      expect(resetSuccessResult.status, AuthStatus.success);
      expect(
        resetSuccessResult.message,
        'Password reset successfully! Please login with your new password.',
      );

      // 5. Old password must fail
      final oldLoginResult = await authService.login(
        email: 'student@campus.edu',
        password: 'OriginalPassword123',
      );
      expect(oldLoginResult.status, AuthStatus.invalidCredentials);

      // 6. New password must succeed
      final newLoginResult = await authService.login(
        email: 'student@campus.edu',
        password: 'NewPassword456',
      );
      expect(newLoginResult.status, AuthStatus.success);
      expect(newLoginResult.user?.email, 'student@campus.edu');
    });
  });

  group('Admin Forgot Password & Reset Tests', () {
    late AdminService adminService;
    late StorageService storageService;

    setUp(() {
      storageService = StorageService();
      adminService = AdminService(storageService: storageService);
    });

    test('Requesting reset for unregistered admin returns noAccountFound', () async {
      final result = await adminService.requestPasswordReset('fakeadmin@campus.edu');
      expect(result.status, AuthStatus.noAccountFound);
      expect(result.message, 'No admin account found with this email.');
    });

    test('Complete Admin Forgot Password and Reset flow', () async {
      // 1. Storage initializes default admin
      final admins = await storageService.getAdmins();
      expect(admins, isNotEmpty);
      final adminEmail = admins.first.email;
      final originalPassword = admins.first.password;

      // 2. Request Admin Password Reset
      final resetReqResult = await adminService.requestPasswordReset(adminEmail);
      expect(resetReqResult.status, AuthStatus.success);
      expect(
        resetReqResult.message,
        'Password reset instructions have been sent to your email.',
      );
      expect(resetReqResult.resetCode, isNotNull);
      final token = resetReqResult.resetCode!;

      // 3. Reset Admin Password
      const newAdminPassword = 'BrandNewAdminPass789';
      final resetSuccessResult = await adminService.resetPassword(
        email: adminEmail,
        token: token,
        newPassword: newAdminPassword,
      );
      expect(resetSuccessResult.status, AuthStatus.success);
      expect(
        resetSuccessResult.message,
        'Password reset successfully! Please login with your new password.',
      );

      // 4. Old password must fail
      final oldLoginResult = await adminService.login(
        email: adminEmail,
        password: originalPassword,
      );
      expect(oldLoginResult.status, AuthStatus.invalidCredentials);

      // 5. New password must succeed
      final newLoginResult = await adminService.login(
        email: adminEmail,
        password: newAdminPassword,
      );
      expect(newLoginResult.status, AuthStatus.success);
      expect(newLoginResult.admin?.email, adminEmail);
    });
  });
}
