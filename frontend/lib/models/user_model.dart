import 'dart:convert';

class UserModel {
  final String? id;
  final String fullName;
  final String email;
  final String password;
  final String department;
  final String? yearSemester;
  final String? studentId;
  final String? phoneNumber;
  final String? avatarUrl;
  final String? gender;
  final String? dateJoined;
  final String? collegeName;

  UserModel({
    this.id,
    required this.fullName,
    required this.email,
    required this.password,
    required this.department,
    this.yearSemester,
    this.studentId,
    this.phoneNumber,
    this.avatarUrl,
    this.gender,
    this.dateJoined,
    this.collegeName,
  });

  UserModel copyWith({
    String? id,
    String? fullName,
    String? email,
    String? password,
    String? department,
    String? yearSemester,
    String? studentId,
    String? phoneNumber,
    String? avatarUrl,
    String? gender,
    String? dateJoined,
    String? collegeName,
  }) {
    return UserModel(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      password: password ?? this.password,
      department: department ?? this.department,
      yearSemester: yearSemester ?? this.yearSemester,
      studentId: studentId ?? this.studentId,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      gender: gender ?? this.gender,
      dateJoined: dateJoined ?? this.dateJoined,
      collegeName: collegeName ?? this.collegeName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'password': password,
      'department': department,
      'yearSemester': yearSemester,
      'studentId': studentId,
      'phoneNumber': phoneNumber,
      'avatarUrl': avatarUrl,
      'gender': gender,
      'dateJoined': dateJoined,
      'collegeName': collegeName,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String?,
      fullName: map['fullName'] as String? ?? '',
      email: map['email'] as String? ?? '',
      password: map['password'] as String? ?? '',
      department: map['department'] as String? ?? '',
      yearSemester: map['yearSemester'] as String?,
      studentId: map['studentId'] as String?,
      phoneNumber: map['phoneNumber'] as String?,
      avatarUrl: map['avatarUrl'] as String?,
      gender: map['gender'] as String?,
      dateJoined: map['dateJoined'] as String?,
      collegeName: map['collegeName'] as String?,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
