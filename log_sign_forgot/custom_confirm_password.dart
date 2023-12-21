import 'package:flutter/material.dart';

class ConfirmPasswordTextField extends StatefulWidget {
  const ConfirmPasswordTextField(
      {Key? key, required this.controller, required this.controllerpass})
      : super(key: key);
  // final String passwordText;
  final TextEditingController controller;
  final TextEditingController controllerpass;
  @override
  State<ConfirmPasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<ConfirmPasswordTextField> {
  var obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        controller: widget.controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: 'Confirm Password',

          contentPadding: EdgeInsets.all(18),
          suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  obscureText = !obscureText;
                });
              },
              child: obscureText
                  ? Icon(
                      Icons.visibility_off,
                      color: Colors.grey,
                    )
                  : Icon(
                      Icons.visibility,
                      color: Color(0xFF228559),
                    )),
          filled: true,
          fillColor: Color(0xFFc0edda), // Background color
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30), // Rounded border
              borderSide: BorderSide.none),
          hintStyle: TextStyle(fontSize: 16, color: Color(0xFF7d7d7d)),
        ),
        style: TextStyle(fontSize: 20, color: Color(0xFF000000)),
        validator: (value) {
          print("value:****** " + value.toString());
          if (value!.isEmpty) {
            return 'Please Enter Confirm Password';
          }
          if (value != widget.controllerpass.text) {
            print(
                "outputtt:***********" + widget.controllerpass.text.toString());
            return 'Password Must be Same';
          }
          // if (value != widget.passwordText) {
          //   print("outputtt:***********" + widget.passwordText.toString());
          //   return 'Password Must be Same';
          // }

          return null;
        },
      ),
    );
  }
}
