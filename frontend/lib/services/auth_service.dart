import '../models/user_model.dart';
import 'storage_service.dart';

enum AuthStatus {
  success,
  noAccountFound,
  invalidCredentials,
  emailAlreadyExists,
  error,
}

class AuthResult {
  final AuthStatus status;
  final String message;
  final UserModel? user;

  const AuthResult({
    required this.status,
    required this.message,
    this.user,
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

  // Get currently authenticated user session
  Future<UserModel?> getCurrentUser() async {
    return await _storageService.getLoggedInUser();
  }

  // Logout current user
  Future<void> logout() async {
    await _storageService.clearLoggedInUser();
  }
}
