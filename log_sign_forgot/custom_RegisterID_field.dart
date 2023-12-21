import 'package:flutter/material.dart';

class RegisterIDTextField extends StatefulWidget {
  const RegisterIDTextField({Key? key, required this.controller})
      : super(key: key);
  final TextEditingController controller;

  @override
  State<RegisterIDTextField> createState() => _RegisterIDTextFieldState();
}

class _RegisterIDTextFieldState extends State<RegisterIDTextField> {
  var obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        keyboardType: TextInputType.number,
        controller: widget.controller,
        decoration: InputDecoration(
          hintText: 'Register ID',
          contentPadding: EdgeInsets.all(18),
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
            return 'Please Enter Register ID';
          }
          return null;
        },
      ),
    );
  }
}
