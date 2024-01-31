import 'package:flutter/material.dart';
import 'package:flutter_project_1st/adminPage/search/searchitems.dart';

import 'searchDetailsAdmin.dart';
import 'searchMeals.dart';
import 'searchOffers.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class searchMain extends StatefulWidget {
  const searchMain({super.key});

  @override
  State<searchMain> createState() => _searchMainState();
}

class _searchMainState extends State<searchMain> {
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
                          builder: (context) => searchDetails(
                                search: "Users",
                              )));
                },
                child: Text(
                  "Search for Users",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                      horizontal: kIsWeb ? 180 : 80, vertical: 15),
                  backgroundColor: Color(0xFF117a5d).withOpacity(0.75),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => searchItems()));
                },
                child: Text(
                  "Serch for Items",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: kIsWeb?180:80, vertical: 15),
                  backgroundColor: Color(0xFF117a5d).withOpacity(0.75),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => searchOffers()));
                },
                child: Text(
                  "Search for Offers",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: kIsWeb?180:80, vertical: 15),
                  backgroundColor: Color(0xFF117a5d).withOpacity(0.75),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => searchMeals()));
                },
                child: Text(
                  "Search for Meals",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: kIsWeb?180:80, vertical: 15),
                  backgroundColor: Color(0xFF117a5d).withOpacity(0.75),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
