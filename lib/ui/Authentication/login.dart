import 'package:classreminderapp/ui/Authentication/signup.dart';
import 'package:classreminderapp/ui/Frontend/Homepage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../backend/auth/controller/dbuser.dart';
import '../../backend/user/usermodel.dart';
import '../Refactor/inputfield.dart';
import '../Refactor/passwordfield.dart';
import '../Refactor/roundedbutton.dart';

enum LoginStatus { notSignIn, signIn }

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Future<SharedPreferences> _pref = SharedPreferences.getInstance();
  final _formkey = GlobalKey<FormState>();

  final matricnumber = TextEditingController();

  final passwordcontroller = TextEditingController();
  DBHelperUser dbHelper = DBHelperUser();

  // @override
  // void initState() {
  //   super.initState();
  //   dbHelper = DBHelperUser();
  // }

  login() async {
    String uid = matricnumber.text;
    String passwd = passwordcontroller.text;

    if (uid.isEmpty) {
      registerToast("Please Enter User ID");
    } else if (passwd.isEmpty) {
      registerToast("Please Enter Password");
    } else {
      await dbHelper.getLoginUser(uid, passwd).then((userData) {
        if (userData != null) {
          setSP(userData).whenComplete(() {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const Homepage()),
                (Route<dynamic> route) => false);
          });
        } else {
          registerToast("Error: User Not Found");
        }
      }).catchError((error) {
        print(error);
        registerToast("Error: Login Fail");
      });
    }
  }

  Future setSP(Usermodel user) async {
    final SharedPreferences sp = await _pref;

    sp.setString("user_id", user.user_id ?? "");
    sp.setString("user_name", user.fname ?? "");
    sp.setString("email", user.email ?? "");
    sp.setString("password", user.password ?? "");
    sp.setString("lname", user.lname ?? "");
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: const Color(0xFF12171D),
        body: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    "WELCOME BACK",
                    style: const TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: size.height * 0.04),
                  RoundedInputField(
                    hintText: "Your Matric number",
                    controller: matricnumber,
                  ),
                  RoundedPasswordField(
                    validate: (inputvalue) {
                      if (inputvalue!.length < 3) {
                        return "Password must be at least 4 character";
                      } else {
                        return null;
                      }
                    },
                    controller: passwordcontroller,
                  ),
                  RoundedButton(
                      text: "LOGIN",
                      press: () async {
                         if (matricnumber.text.isEmpty) {
      registerToast("Please Enter User ID");
    } else if (passwordcontroller.text.isEmpty) {
      registerToast("Please Enter Password");
    } else {
      await dbHelper.getLoginUser(matricnumber.text, passwordcontroller.text ).then((userData) {
        if (userData != null) {
          setSP(userData).whenComplete(() {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const Homepage()),
                (Route<dynamic> route) => false);
          });
        } else {
          registerToast("Error: User Not Found");
        }
      }).catchError((error) {
        print(error);
        registerToast("Error: Login Fail");
      });
    }
                      }

                
                      ),
                  SizedBox(height: size.height * 0.03),
                  AlreadyHaveAnAccountCheck(
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return SignUpScreen();
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ));
  }

}

class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final bool login;
  final Function()? press;
  const AlreadyHaveAnAccountCheck({
    Key? key,
    this.login = true,
    this.press,
  }) : super(key: key);

  get kPrimaryColor => null;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          login ? "Don’t have an Account ? " : "Already have an Account ? ",
          style: const TextStyle(
              fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        GestureDetector(
          onTap: press,
          child: Text(
            login ? "Register" : "Sign In",
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}
