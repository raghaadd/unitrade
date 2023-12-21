import 'package:flutter/material.dart';

class PasswordTextField extends StatefulWidget {
  const PasswordTextField(
      {Key? key, required this.controller})
      : super(key: key);
  final TextEditingController controller;

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  var obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        controller: widget.controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: 'Password',

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
          if (value!.isEmpty) {
            return 'Please Enter Password';
          }
          return null;
        },
      ),
    );
  }
}
