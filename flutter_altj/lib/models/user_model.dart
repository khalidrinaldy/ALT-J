import 'dart:convert';
class User {
  final String email, username;
  User(this.email, this.username);
}

class UserModel {
  String email, username;
  UserModel({this.email, this.username});

  factory UserModel.fromJson(Map json) => UserModel(
    email: json['email'],
    username: json['username'],
  );

  Map toJson() => {
    'email': email,
    'username': username,
  };
}

UserModel userModelFromJson(String str) => userModelFromJson(json.decode(str));
String UserModelToJson(UserModel data) => json.encode(data.toJson());