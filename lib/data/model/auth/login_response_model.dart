import 'dart:convert';

import '../User/user.model.dart';


LoginResponseModel loginResponseModelFromJson(String str) =>
    LoginResponseModel.fromJson(json.decode(str));

String loginResponseModelToJson(LoginResponseModel data) =>
    json.encode(data.toJson());

class LoginResponseModel {
  String? message;
  String? status;
  Data? data;

  LoginResponseModel({
    this.status,
    this.message,
    this.data,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      LoginResponseModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]
      ),
  );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message":message,
        "data": data?.toJson(),
  };
}

class Data {
  String? accessToken;
  User? user;
  String? tokenType;

  Data({
    this.accessToken,
    this.user,
    this.tokenType,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        accessToken: json["accessToken"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        tokenType: json["tokenType"],
      );

  Map<String, dynamic> toJson() => {
        "accessToken": accessToken,
        "user": user?.toJson(),
        "tokenType": tokenType,
      };
}
