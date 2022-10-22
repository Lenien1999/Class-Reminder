
import 'package:flutter/material.dart';

import '../../../constant/colorcon.dart';
import 'textfield.dart';

class RoundedPasswordField extends StatefulWidget {
  final TextEditingController controller;
  final String? Function(String?)? validate;
  const RoundedPasswordField({
    Key? key,
    required this.controller,
    this.validate,
  }) : super(key: key);

  @override
  State<RoundedPasswordField> createState() => _RoundedPasswordFieldState();
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {
  @override
  Widget build(BuildContext context) {
    bool isvisible = false;
    return TextFieldContainer(
      child: TextFormField(
        
        validator: widget.validate,
        controller: widget.controller,
        obscureText: isvisible,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          contentPadding:EdgeInsets.only(top:20),
          hintText: "Password",
          icon: Icon(
            Icons.lock,
            color: kPrimaryColor,
          ),
          suffixIcon: IconButton(
              color: kPrimaryColor,
              onPressed: () {
                setState(() {
                  isvisible = !isvisible;
                });
              },
              icon: isvisible
                  ? const Icon(Icons.visibility)
                  : const Icon(Icons.visibility_off)),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
