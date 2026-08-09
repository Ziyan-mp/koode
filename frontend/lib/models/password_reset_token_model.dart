import 'dart:convert';

class PasswordResetToken {
  final String email;
  final String token;
  final DateTime expiresAt;
  final String accountType; // 'user' or 'admin'

  PasswordResetToken({
    required this.email,
    required this.token,
    required this.expiresAt,
    required this.accountType,
  });

  bool get isExpired => DateTime.now().isAfter(expiresAt);

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'token': token,
      'expiresAt': expiresAt.toIso8601String(),
      'accountType': accountType,
    };
  }

  factory PasswordResetToken.fromMap(Map<String, dynamic> map) {
    return PasswordResetToken(
      email: map['email'] as String? ?? '',
      token: map['token'] as String? ?? '',
      expiresAt: DateTime.tryParse(map['expiresAt'] as String? ?? '') ??
          DateTime.now().add(const Duration(minutes: 15)),
      accountType: map['accountType'] as String? ?? 'user',
    );
  }

  String toJson() => json.encode(toMap());

  factory PasswordResetToken.fromJson(String source) =>
      PasswordResetToken.fromMap(json.decode(source) as Map<String, dynamic>);
}
