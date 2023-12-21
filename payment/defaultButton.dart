import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  final String btnText;
  final VoidCallback onPressed;
  final Color buttonColor;

  const DefaultButton({
    required this.btnText,
    required this.onPressed,
    this.buttonColor = const Color(0xFF117a5d),
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.9,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: this.buttonColor,
          textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        child: Text(
          btnText,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
