// ignore_for_file: constant_identifier_names, non_constant_identifier_names, prefer_const_constructors, invalid_return_type_for_catch_error

import 'package:classreminderapp/backend/auth/controller/response.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../ui/Frontend/Homepage.dart';
import '../authmodel.dart';

class RegisterController {
  static const String CONTENT_TYPE = 'application/json';
  static const headers = {'Content-Type': CONTENT_TYPE};

  Future createUser(RegisterModel register) {
    const String url = "http://10.0.2.2:8000/user";
    return http
        .post(Uri.parse("$url/register/"),
            headers: headers, body: jsonEncode(register.toJson()))
        .then((data) {
      if (data.statusCode == 201) {
        return registerToast("Register sucessfull");
      } else if (data.statusCode == 400) {
        registerToast("A user with that username already exists");
      }
      return ApiResponse<bool>(
          isError: true, errorMessage: 'An error occurred');
    }).catchError((_) => registerToast("Register fail"));
  }

 
// Future<UserModel> fetchUser() async {
//   const String _url = "http://10.0.2.2:8000/user";
//   final response = await http
//       .get(Uri.parse("${_url}/me"));

//   if (response.statusCode == 200) {
   
//     return UserModel.fromJson(jsonDecode(response.body));
//   } else {
    
//     throw Exception('Failed to load User Profile');
//   }
// }

Future<void> LoginAuth(BuildContext context, UserLogin logincred ) async {
    const String url = "http://10.0.2.2:8000/user";
       await http
        .post(Uri.parse("$url/login/"),
           headers: headers, body: jsonEncode(logincred.toJson()))
        .then((data) {
      if (data.statusCode == 200) {
          
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return const Homepage();
          
          
        }));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(
              SnackBar(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                backgroundColor:Colors.red,
                content: SizedBox(
                  height: 100,
                  child: const Center(child: Text("Invalid Credentials",style:TextStyle(fontSize:18) )  ))));
      }
    }).catchError((e ) => ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString()))
            ));
  }

  registerToast(String toast) {
    return Fluttertoast.showToast(
        msg: toast,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor:
            toast == "Register sucessfull" ? Colors.green : Colors.red,
        textColor: Colors.white);
  }












}
