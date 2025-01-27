// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String id;
  String token;
  String user;
  double balance;

  UserModel({
    required this.id,
    required this.token,
    required this.user,
    required this.balance,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        token: json["token"],
        user: json["user"],
        balance: json["balance"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "token": token,
        "user": user,
        "balance": balance,
      };
}
