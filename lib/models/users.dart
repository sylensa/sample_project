// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String? username;
  String? localArea;
  double? mileRadius;

  UserModel({
    this.username,
    this.localArea,
    this.mileRadius,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    username: json["username"],
    localArea: json["localArea"],
    mileRadius: json["mileRadius"],
  );

  Map<String, dynamic> toJson() => {
    "username": username,
    "localArea": localArea,
    "mileRadius": mileRadius,
  };
}
