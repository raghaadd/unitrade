import 'package:flutter/material.dart';
import 'package:flutter_project_1st/homepage/hidden_drawer.dart';
import 'package:lottie/lottie.dart';

class SuccessScreen extends StatefulWidget {
  const SuccessScreen({Key? key}) : super(key: key);

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  @override
  void initState() {
    super.initState();
    
    Future.delayed(Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => HiddenDrawer(
                  page: 0,
                )),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
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
  }
}
