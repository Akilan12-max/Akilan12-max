// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    final this.token,
    final this.email,
    final this.password,
  });

  final String token;
  final String email;
  final String password;

  factory User.fromJson(Map<String, dynamic> json) => User(
        token: json["token"],
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "email": email,
        "password": password,
      };
}

class TokenNotifier {
  static String token;
}
