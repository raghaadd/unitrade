import 'package:flutter/material.dart';
import 'package:flutter_project_1st/log_sign_forgot/loginpage.dart';
import 'package:flutter_project_1st/pages/page1.dart';
import 'package:flutter_project_1st/pages/page2.dart';
import 'package:flutter_project_1st/pages/page3.dart';
import 'package:flutter_project_1st/pages/page4.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class getStarted extends StatelessWidget {
  final _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF33c787),
                  Color(0xFF228559),
                  Color(0xFF17573b),
                ],
                begin: Alignment.topCenter,
                // end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                    height: 700,
                    child: PageView(
                      controller: _controller,
                      children: const [
                        page1(),
                        page2(),
                        page3(),
                        page4(),
                      ],
                    )),
                //dot direction:
                SmoothPageIndicator(
                  controller: _controller,
                  count: 4,
                  effect: JumpingDotEffect(
                    activeDotColor: Color(0xFFffffff),
                    dotColor: Colors.grey,
                    dotHeight: 15,
                    dotWidth: 15,
                    spacing: 10,
                    verticalOffset: 20,
                  ),
                ),
                SizedBox(
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => login()));
                    },
                    child: Text(
                      'Get Started',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Color(0xFF000000)),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color(0xFFffffff)), // Change the color here
                    ),
                  ),
                ),
              ],
            )));
  }
}
