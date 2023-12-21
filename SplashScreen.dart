import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_1st/getStarted.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    _navigatetohome();
  }

  _navigatetohome() async {
    await Future.delayed(Duration(milliseconds: 3000), () {});
    //after wait for 1.5 sec navigate to home screen:
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => getStarted()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image(image: AssetImage('assets/deal_icon.png')),
        Container(
            child: const Text('UniTrade',
                style: TextStyle(
                  fontSize: 70,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF117a5d),
                ))),
        const SizedBox(height: 20), // Add some spacing
        CircularProgressIndicator(
          color: Color(0xFFd6d6d6),
        ),
      ],
    )));
  }
}
