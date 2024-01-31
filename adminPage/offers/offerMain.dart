import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'offerNames.dart';

class offerMain extends StatefulWidget {
  const offerMain({super.key});

  @override
  State<offerMain> createState() => _offerMainState();
}

class _offerMainState extends State<offerMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              // Text(
              //   "Choose:",
              //   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              // ),
              SizedBox(
                height: 30,
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => offerNames(
                                offerCategory: 1,
                              )));
                },
                child: Text(
                  "Electronics",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal:kIsWeb?180: 80, vertical: 15),
                  backgroundColor: Color(0xFF117a5d)
                      .withOpacity(0.75), // Change background color (optional)
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // Rounded corners
                  ),
                  // Add more styling as required
                ),
              ),
              SizedBox(
                height: 30,
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => offerNames(
                                offerCategory: 2,
                              )));
                },
                child: Text(
                  "Electricals  ",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: kIsWeb?180:80, vertical: 15),
                  backgroundColor: Color(0xFF117a5d)
                      .withOpacity(0.75), // Change background color (optional)
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // Rounded corners
                  ),
                  // Add more styling as required
                ),
              ),
              SizedBox(
                height: 30,
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => offerNames(
                                offerCategory: 3,
                              )));
                },
                child: Text(
                  "Furnitures   ",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal:kIsWeb?180:80, vertical: 15),
                  backgroundColor: Color(0xFF117a5d)
                      .withOpacity(0.75), // Change background color (optional)
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // Rounded corners
                  ),
                  // Add more styling as required
                ),
              ),
              SizedBox(
                height: 30,
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => offerNames(
                                offerCategory: 4,
                              )));
                },
                child: Text(
                  "Restaurants",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal:kIsWeb?180: 80, vertical: 15),
                  backgroundColor: Color(0xFF117a5d)
                      .withOpacity(0.75), // Change background color (optional)
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // Rounded corners
                  ),
                  // Add more styling as required
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
