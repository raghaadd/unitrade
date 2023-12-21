import 'package:flutter/material.dart';

class page3 extends StatelessWidget {
  const page3({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Stack(
            children: [
              Container(
                //color: Color(0xFF33c787)
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
              ),
              Center(
                child: Column(
                  children: [
                    SizedBox(height: 80),
                    Text('Features in',
                        style: TextStyle(fontSize: 35, color: Colors.white)),
                    Text('UniTrade.',
                        style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                    SizedBox(height: 40),
                    Image(
                        image: AssetImage('assets/pages/page3_remove.png'),
                        height: 200,
                        width: 200),
                    SizedBox(height: 20),
                    Center(
                      child: Text(
                        'Features include initiating a chat with the product owner, rating system, administrator oversees all aspects of the application and introduces various services aimed at improving students\' lives.',
                        style:
                            TextStyle(fontSize: 18, color: Color(0xFFffffff)),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
