//  // To parse this JSON data, do
// //
// //     final userModel = userModelFromJson(jsonString);

// import 'dart:convert';

// UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

// String userModelToJson(UserModel data) => json.encode(data.toJson());

// class UserModel {
//   UserModel({
//     this.id,
//     this.firstName,
//     this.lastName,
//     this.email,
//   });

//   int? id;
//   String? firstName;
//   String? lastName;
//   String? email;

//   factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
//         id: json["id"],
//         firstName: json["first_name"],
//         lastName: json["last_name"],
//         email: json["email"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "first_name": firstName,
//         "last_name": lastName,
//         "email": email,
//       };
// }

// ignore_for_file: non_constant_identifier_names

class Usermodel {
  String? user_id;
  String? email;
  String? password;
  String? fname;
  String? lname;

  Usermodel(this.user_id, this.email, this.password, this.fname,
      this.lname);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'user_id': user_id,
      'email': email,
      'password': password,
      'lname': lname,
      'fname': fname,
    };
    return map;
  }

  Usermodel.fromMap(Map<String, dynamic> map) {
    user_id = map['user_id'];
    email = map['email'];
    password = map['password'];
    fname = map['fname'];
    lname = map['lname'];
  }
}
