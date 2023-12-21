import 'package:flutter/material.dart';
import 'package:one_context/one_context.dart';
import 'package:lottie/lottie.dart';
class UIHelper {
  static showAlerDialog(String message, {title = ''}){
    OneContext().showDialog(builder: (BuildContext context){
      return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Lottie.asset(
          'assets/success.json',
          width: 200, 
          height: 300,
        ),
      ),
    );
    },);
  }
}
