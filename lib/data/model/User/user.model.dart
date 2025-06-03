// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  final String? id;
  final String? name;
  final String fullName;
  final String email;

  User({
    this.id,
    required this.email,
    required this.name,
    required this.fullName,
  });

  User copyWith({
    String? id,
    String? email,
    String? name,
    String? fullName,
  }) =>
      User(
        id: id ?? this.id,
        email: email ?? this.email,
        name: name ?? this.name,
        fullName: fullName ?? this.fullName,
      );

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["_id"] ?? "",
    email: json["email"] ?? "",
    name: json["name"] ?? "",
    fullName: json["fullName"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "name": name,
    "fullName": fullName,
  };
}
