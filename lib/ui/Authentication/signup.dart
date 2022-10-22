// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../backend/auth/controller/dbuser.dart';
import '../../backend/user/usermodel.dart';
import '../../constant/background.dart';

import '../Refactor/inputfield.dart';
import '../Refactor/passwordfield.dart';
import '../Refactor/roundedbutton.dart';
import 'booleanbutton.dart';
import 'login.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // RegisterController registerController = RegisterController();

  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final matricnunmber = TextEditingController();
  final fnamee = TextEditingController();
  final lnamee = TextEditingController();

  DBHelperUser dbHelper = DBHelperUser();

  // @overrid
  // void initState() {
  //   super.initState();
  //   dbHelper = DBHelperUser();
  // }

  final _formkey = GlobalKey<FormState>();
  signUp() async {
    String uid = matricnunmber.text;
    String fname = fnamee.text;
    String email = emailcontroller.text;
    String passwd = passwordcontroller.text;
    String lname = lnamee.text;

    if (_formkey.currentState!.validate()) {
      _formkey.currentState!.save();

      Usermodel uModel = Usermodel(uid, fname, email, passwd, lname);
      await dbHelper.saveData(uModel).then((userData) {
        print(uModel);
        registerToast("Successfully Saved");

        Navigator.push(
            context, MaterialPageRoute(builder: (_) => const LoginScreen()));
      }).catchError((error) {
        print(error);
        registerToast("Error: Data Save Fail");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;


    return Scaffold(
      backgroundColor: const Color(0xFF12171D),
      body: Background(
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  "Welcome",
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: size.height * 0.03),
                // SvgPicture.asset(
                //   "assets/icons/signup.svg",
                //   height: size.height * 0.35,
                // ),
                RoundedInputField(
                  hintText: "Your Email",
                  controller: passwordcontroller,
                  validate: (String? inputvalue) {
                    final RegExp emailRegex = RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

                    if (!emailRegex.hasMatch(inputvalue.toString())) {
                      return " Email format is invalid";
                    } else {
                      return null;
                    }
                  },
                ),
                RoundedInputField(hintText: "First name", controller: fnamee),
                RoundedInputField(hintText: "Last Name", controller: lnamee),
                RoundedInputField(
                    hintText: "Matric Num", controller: matricnunmber),

                RoundedPasswordField(
                    controller: emailcontroller,
                    validate: (inputvalue) {
                      if (inputvalue!.length < 3) {
                        return "Password must be at least 6 character";
                      } else {
                        return null;
                      }
                    }),
                SwitchScreen(),
                RoundedButton(
                    text: "SIGNUP",
                    press: () {
                      signUp();
                    }),
                
                SizedBox(height: size.height * 0.03),

                AlreadyHaveAnAccountCheck(
                  login: false,
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const LoginScreen();
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
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
