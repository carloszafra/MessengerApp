// To parse this JSON data, do
//
//     final usersListResponse = usersListResponseFromJson(jsonString);

import 'dart:convert';
import 'package:ChatApp/models/users.dart';

UsersListResponse usersListResponseFromJson(String str) =>
    UsersListResponse.fromJson(json.decode(str));

String usersListResponseToJson(UsersListResponse data) =>
    json.encode(data.toJson());

class UsersListResponse {
  UsersListResponse({
    this.ok,
    this.users,
  });

  bool ok;
  List<User> users;

  factory UsersListResponse.fromJson(Map<String, dynamic> json) =>
      UsersListResponse(
        ok: json["ok"],
        users: List<User>.from(json["users"].map((x) => User.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "users": List<dynamic>.from(users.map((x) => x.toJson())),
      };
}
