import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/admin_model.dart';
import '../models/complaint_model.dart';
import '../models/password_reset_token_model.dart';
import '../models/user_model.dart';

class StorageService {
  static const String _usersKey = 'registered_users';
  static const String _currentUserKey = 'current_user';
  static const String _adminsKey = 'registered_admins';
  static const String _currentAdminKey = 'current_admin';
  static const String _resetTokensKey = 'password_reset_tokens';
  static const String _complaintsKey = 'user_complaints';

  // ==================== USER STORAGE ====================

  // Get all registered users
  Future<List<UserModel>> getUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final String? usersJson = prefs.getString(_usersKey);
    if (usersJson == null || usersJson.isEmpty) return [];
    try {
      final List<dynamic> jsonList = json.decode(usersJson);
      return jsonList
          .map((item) => UserModel.fromMap(item as Map<String, dynamic>))
          .toList();
    } catch (_) {
      return [];
    }
  }

  // Save or update user
  Future<void> saveUser(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    final users = await getUsers();

    final index = users.indexWhere(
      (u) => u.email.trim().toLowerCase() == user.email.trim().toLowerCase(),
    );
    if (index != -1) {
      users[index] = user;
    } else {
      users.add(user);
    }

    final String encoded = json.encode(users.map((u) => u.toMap()).toList());
    await prefs.setString(_usersKey, encoded);

    // If updating current logged in user, refresh session storage
    final currentUser = await getLoggedInUser();
    if (currentUser != null &&
        currentUser.email.trim().toLowerCase() == user.email.trim().toLowerCase()) {
      await saveLoggedInUser(user);
    }
  }

  // Update only password for user
  Future<bool> updateUserPassword(String email, String newPassword) async {
    final prefs = await SharedPreferences.getInstance();
    final users = await getUsers();
    final targetEmail = email.trim().toLowerCase();

    final index = users.indexWhere(
      (u) => u.email.trim().toLowerCase() == targetEmail,
    );
    if (index == -1) return false;

    users[index] = users[index].copyWith(password: newPassword);
    final String encoded = json.encode(users.map((u) => u.toMap()).toList());
    await prefs.setString(_usersKey, encoded);

    // If updating current logged in user, refresh session storage
    final currentUser = await getLoggedInUser();
    if (currentUser != null &&
        currentUser.email.trim().toLowerCase() == targetEmail) {
      await saveLoggedInUser(users[index]);
    }
    return true;
  }

  // Find user by email
  Future<UserModel?> getUserByEmail(String email) async {
    final users = await getUsers();
    final targetEmail = email.trim().toLowerCase();
    try {
      return users.firstWhere(
        (u) => u.email.trim().toLowerCase() == targetEmail,
      );
    } catch (_) {
      return null;
    }
  }

  // Check registered users
  Future<bool> hasRegisteredUsers() async {
    final users = await getUsers();
    return users.isNotEmpty;
  }

  // Save active login session
  Future<void> saveLoggedInUser(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_currentUserKey, user.toJson());
  }

  // Get active login session
  Future<UserModel?> getLoggedInUser() async {
    final prefs = await SharedPreferences.getInstance();
    final String? userJson = prefs.getString(_currentUserKey);
    if (userJson == null || userJson.isEmpty) return null;
    try {
      return UserModel.fromJson(userJson);
    } catch (_) {
      return null;
    }
  }

  // Logout session
  Future<void> clearLoggedInUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_currentUserKey);
  }

  // ==================== ADMIN STORAGE ====================

  // Default seed admins to initialize if storage is empty
  List<AdminModel> _getDefaultAdmins() {
    return [
      AdminModel(
        id: 'admin_1',
        fullName: 'Campus Admin',
        email: 'admin@campus.edu',
        password: 'Password@123',
        department: 'Campus Administration',
        role: 'Super Admin',
      ),
      AdminModel(
        id: 'admin_2',
        fullName: 'Principal Office',
        email: 'principal@campus.edu',
        password: 'Password@123',
        department: 'Executive Office',
        role: 'Dean / Principal',
      ),
    ];
  }

  // Get all registered admins
  Future<List<AdminModel>> getAdmins() async {
    final prefs = await SharedPreferences.getInstance();
    final String? adminsJson = prefs.getString(_adminsKey);
    if (adminsJson == null || adminsJson.isEmpty) {
      // Seed default admins on first launch
      final defaultAdmins = _getDefaultAdmins();
      final String encoded =
          json.encode(defaultAdmins.map((a) => a.toMap()).toList());
      await prefs.setString(_adminsKey, encoded);
      return defaultAdmins;
    }
    try {
      final List<dynamic> jsonList = json.decode(adminsJson);
      return jsonList
          .map((item) => AdminModel.fromMap(item as Map<String, dynamic>))
          .toList();
    } catch (_) {
      return [];
    }
  }

  // Save or update admin
  Future<void> saveAdmin(AdminModel admin) async {
    final prefs = await SharedPreferences.getInstance();
    final admins = await getAdmins();

    final index = admins.indexWhere(
      (a) => a.email.trim().toLowerCase() == admin.email.trim().toLowerCase(),
    );
    if (index != -1) {
      admins[index] = admin;
    } else {
      admins.add(admin);
    }

    final String encoded = json.encode(admins.map((a) => a.toMap()).toList());
    await prefs.setString(_adminsKey, encoded);

    final currentAdmin = await getLoggedInAdmin();
    if (currentAdmin != null &&
        currentAdmin.email.trim().toLowerCase() == admin.email.trim().toLowerCase()) {
      await saveLoggedInAdmin(admin);
    }
  }

  // Update only password for admin
  Future<bool> updateAdminPassword(String email, String newPassword) async {
    final prefs = await SharedPreferences.getInstance();
    final admins = await getAdmins();
    final targetEmail = email.trim().toLowerCase();

    final index = admins.indexWhere(
      (a) => a.email.trim().toLowerCase() == targetEmail,
    );
    if (index == -1) return false;

    admins[index] = admins[index].copyWith(password: newPassword);
    final String encoded = json.encode(admins.map((a) => a.toMap()).toList());
    await prefs.setString(_adminsKey, encoded);

    final currentAdmin = await getLoggedInAdmin();
    if (currentAdmin != null &&
        currentAdmin.email.trim().toLowerCase() == targetEmail) {
      await saveLoggedInAdmin(admins[index]);
    }
    return true;
  }

  // Find admin by email
  Future<AdminModel?> getAdminByEmail(String email) async {
    final admins = await getAdmins();
    final targetEmail = email.trim().toLowerCase();
    try {
      return admins.firstWhere(
        (a) => a.email.trim().toLowerCase() == targetEmail,
      );
    } catch (_) {
      return null;
    }
  }

  // Check registered admins
  Future<bool> hasRegisteredAdmins() async {
    final admins = await getAdmins();
    return admins.isNotEmpty;
  }

  // Save active admin session
  Future<void> saveLoggedInAdmin(AdminModel admin) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_currentAdminKey, admin.toJson());
  }

  // Get active admin session
  Future<AdminModel?> getLoggedInAdmin() async {
    final prefs = await SharedPreferences.getInstance();
    final String? adminJson = prefs.getString(_currentAdminKey);
    if (adminJson == null || adminJson.isEmpty) return null;
    try {
      return AdminModel.fromJson(adminJson);
    } catch (_) {
      return null;
    }
  }

  // Logout admin session
  Future<void> clearLoggedInAdmin() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_currentAdminKey);
  }

  // ==================== RESET TOKEN STORAGE ====================

  // Save a password reset token
  Future<void> saveResetToken(PasswordResetToken token) async {
    final prefs = await SharedPreferences.getInstance();
    final tokens = await _getResetTokens();

    final index = tokens.indexWhere(
      (t) => t.email.trim().toLowerCase() == token.email.trim().toLowerCase(),
    );
    if (index != -1) {
      tokens[index] = token;
    } else {
      tokens.add(token);
    }

    final String encoded = json.encode(tokens.map((t) => t.toMap()).toList());
    await prefs.setString(_resetTokensKey, encoded);
  }

  // Internal helper to get all tokens
  Future<List<PasswordResetToken>> _getResetTokens() async {
    final prefs = await SharedPreferences.getInstance();
    final String? tokensJson = prefs.getString(_resetTokensKey);
    if (tokensJson == null || tokensJson.isEmpty) return [];
    try {
      final List<dynamic> jsonList = json.decode(tokensJson);
      return jsonList
          .map((item) =>
              PasswordResetToken.fromMap(item as Map<String, dynamic>))
          .toList();
    } catch (_) {
      return [];
    }
  }

  // Get reset token for an email
  Future<PasswordResetToken?> getResetToken(String email) async {
    final tokens = await _getResetTokens();
    final targetEmail = email.trim().toLowerCase();
    try {
      return tokens.firstWhere(
        (t) => t.email.trim().toLowerCase() == targetEmail,
      );
    } catch (_) {
      return null;
    }
  }

  // Clear reset token after use
  Future<void> clearResetToken(String email) async {
    final prefs = await SharedPreferences.getInstance();
    final tokens = await _getResetTokens();
    final targetEmail = email.trim().toLowerCase();

    tokens.removeWhere((t) => t.email.trim().toLowerCase() == targetEmail);
    final String encoded = json.encode(tokens.map((t) => t.toMap()).toList());
    await prefs.setString(_resetTokensKey, encoded);
  }

  // ==================== COMPLAINT STORAGE ====================

  // Get all complaints stored locally
  Future<List<ComplaintModel>> getComplaints() async {
    final prefs = await SharedPreferences.getInstance();
    final String? complaintsJson = prefs.getString(_complaintsKey);
    if (complaintsJson == null || complaintsJson.isEmpty) return [];
    try {
      final List<dynamic> jsonList = json.decode(complaintsJson);
      return jsonList
          .map((item) => ComplaintModel.fromMap(item as Map<String, dynamic>))
          .toList();
    } catch (_) {
      return [];
    }
  }

  // Get complaints for a specific user email
  Future<List<ComplaintModel>> getComplaintsForUser(String email) async {
    final all = await getComplaints();
    final targetEmail = email.trim().toLowerCase();
    return all
        .where((c) => c.userEmail.trim().toLowerCase() == targetEmail)
        .toList();
  }

  // Save new complaint or update existing complaint
  Future<void> saveComplaint(ComplaintModel complaint) async {
    final prefs = await SharedPreferences.getInstance();
    final complaints = await getComplaints();

    final index = complaints.indexWhere((c) => c.id == complaint.id);
    if (index != -1) {
      complaints[index] = complaint;
    } else {
      complaints.insert(0, complaint);
    }

    final String encoded =
        json.encode(complaints.map((c) => c.toMap()).toList());
    await prefs.setString(_complaintsKey, encoded);
  }
}
