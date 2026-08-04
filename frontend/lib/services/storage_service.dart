import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/complaint_model.dart';
import '../models/user_model.dart';

class StorageService {
  static const String _usersKey = 'registered_users';
  static const String _currentUserKey = 'current_user';
  static const String _complaintsKey = 'user_complaints';

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
