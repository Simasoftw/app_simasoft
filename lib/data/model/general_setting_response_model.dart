import 'dart:convert';

import 'package:app_simasoft/data/model/User/user.model.dart';


GeneralSettingResponseModel generalSettingResponseModelFromJson(String str) =>
    GeneralSettingResponseModel.fromJson(json.decode(str));

String generalSettingResponseModelToJson(GeneralSettingResponseModel data) =>
    json.encode(data.toJson());

class GeneralSettingResponseModel {
  String? status;
  String? message;
  User? data;

  GeneralSettingResponseModel({
    this.status,
    this.message,
    this.data,
  });

  factory GeneralSettingResponseModel.fromJson(Map<String, dynamic> json) =>
      GeneralSettingResponseModel(
        status: json["status"],
        message: json["message"] ?? "",
        data: json["data"] == null ? null : User.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message ?? "",
        "data": data?.toJson(),
  };
}

