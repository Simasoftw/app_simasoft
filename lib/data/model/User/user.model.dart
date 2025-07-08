// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  final int id;
  final String? name;
  final String  fullName;
  final String  email;
  final String? birthdayBonus;
  final String? birthDate;

  User({
    required this.id,
    required this.email,
    required this.name,
    required this.fullName,
    required this.birthdayBonus,
    required this.birthDate,
  });

  User copyWith({
    required int id,
    String? email,
    String? name,
    String? fullName,
    String? birthdayBonus,
    String? birthDate,
  }) =>
      User(
        id: id ,
        email: email ?? this.email,
        name: name ?? this.name,
        fullName: fullName ?? this.fullName,
        birthdayBonus: birthdayBonus ?? this.birthdayBonus,
        birthDate: birthDate ?? this.birthDate,
      );

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["_id"] ?? 0,
    email: json["email"] ?? "",
    name: json["name"] ?? "",
    fullName: json["fullName"] ?? "",
    birthdayBonus: json["birthdayBonus"] ?? "",
    birthDate: json["birthDate"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "name": name,
    "fullName": fullName,
    "birthdayBonus": birthdayBonus,
    "birthDate": birthDate,
  };
}
