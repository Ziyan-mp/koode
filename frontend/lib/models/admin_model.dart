import 'dart:convert';

class AdminModel {
  final String id;
  final String fullName;
  final String email;
  final String password;
  final String department;
  final String role;
  final String? phoneNumber;
  final String? avatarUrl;
  final String? createdAt;

  AdminModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.password,
    required this.department,
    this.role = 'Admin',
    this.phoneNumber,
    this.avatarUrl,
    this.createdAt,
  });

  AdminModel copyWith({
    String? id,
    String? fullName,
    String? email,
    String? password,
    String? department,
    String? role,
    String? phoneNumber,
    String? avatarUrl,
    String? createdAt,
  }) {
    return AdminModel(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      password: password ?? this.password,
      department: department ?? this.department,
      role: role ?? this.role,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'password': password,
      'department': department,
      'role': role,
      'phoneNumber': phoneNumber,
      'avatarUrl': avatarUrl,
      'createdAt': createdAt,
    };
  }

  factory AdminModel.fromMap(Map<String, dynamic> map) {
    return AdminModel(
      id: map['id'] as String? ?? '',
      fullName: map['fullName'] as String? ?? '',
      email: map['email'] as String? ?? '',
      password: map['password'] as String? ?? '',
      department: map['department'] as String? ?? 'Campus Administration',
      role: map['role'] as String? ?? 'Admin',
      phoneNumber: map['phoneNumber'] as String?,
      avatarUrl: map['avatarUrl'] as String?,
      createdAt: map['createdAt'] as String?,
    );
  }

  String toJson() => json.encode(toMap());

  factory AdminModel.fromJson(String source) =>
      AdminModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
