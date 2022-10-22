
// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

RegisterModel registerModelFromJson(String str) => RegisterModel.fromJson(json.decode(str));

String registerModelToJson(RegisterModel data) => json.encode(data.toJson());

class RegisterModel {
    RegisterModel({
        this.id,
       this.firstName,
        this.lastName,
     required   this.email,
       required this.password,
    });

    int ?id;
    String ?firstName;
    String ?lastName;
    String email;
    String password;

    factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        password: json["password"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "password": password,
    };
}

// To parse this JSON data, do
//
//     final userLogin = userLoginFromJson(jsonString);

// To parse this JSON data, do
//
//     final userLogin = userLoginFromJson(jsonString);

 

UserLogin userLoginFromJson(String str) => UserLogin.fromJson(json.decode(str));

String userLoginToJson(UserLogin data) => json.encode(data.toJson());

class UserLogin {
    UserLogin({
        this.id,
        this.email,
        this.password,
    });

    int? id;
    String? email;
    String ?password;

    factory UserLogin.fromJson(Map<String, dynamic> json) => UserLogin(
        id: json["id"],
        email: json["email"],
        password: json["password"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "password": password,
    };
}
class UserModel {
  String ?user_id;
  String ?user_name;
  String ?email;
  String ?password;

  UserModel(this.user_id, this.user_name, this.email, this.password);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'user_id': user_id,
      'user_name': user_name,
      'email': email,
      'password': password
    };
    return map;
  }

  UserModel.fromMap(Map<String, dynamic> map) {
    user_id = map['user_id'];
    user_name = map['user_name'];
    email = map['email'];
    password = map['password'];
  }
}
