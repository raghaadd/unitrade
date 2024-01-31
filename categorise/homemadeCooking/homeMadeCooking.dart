import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:flutter_project_1st/categorise/appbar_page.dart';
import 'package:flutter_project_1st/categorise/homemadeCooking/whatDoYouWantEat.dart';
import 'package:flutter_project_1st/generated/l10n.dart';
import 'package:flutter_project_1st/ipaddress.dart';
import 'package:flutter_project_1st/settingpage/theme/theme_provider.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'homeMadeDetails.dart';

class homeMadeCookingMain extends StatefulWidget {
  final int index;
  final int registerid;
  const homeMadeCookingMain(
      {super.key, required this.index, required this.registerid});

  @override
  State<homeMadeCookingMain> createState() => _homeMadeCookingMainState();
}

class _homeMadeCookingMainState extends State<homeMadeCookingMain> {
  late final PageController pageController;
  List<Map<String, dynamic>> meals = [];
  List<Map<String, dynamic>> bestMeals = [];
  @override
  void initState() {
    pageController = PageController(initialPage: 0, viewportFraction: 0.85);
    super.initState();
    initializeData();
  }

  Future<void> initializeData() async {
    try {
      meals = await getMeals();
      bestMeals = await getBestMeals();
      print('Meals: $meals');

      if (meals.isNotEmpty) {
        setState(() {
          meals = meals;
          bestMeals = bestMeals;
        });
      }
    } catch (error) {
      // Provide more meaningful error handling or logging
      print('Error initializing data: $error');
    }
  }

  Future<List<Map<String, dynamic>>> getMeals() async {
    final ipAddress = await getLocalIPv4Address();
    final String apiUrl = "http://$ipAddress:3000/getMeals";

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        // Parse the response body
        List<dynamic> data = json.decode(response.body);

        // Convert the list of dynamic to List<Map<String, dynamic>>
        List<Map<String, dynamic>> meals =
            List<Map<String, dynamic>>.from(data);
        return meals;
      } else {
        throw Exception(
            'Failed to load reserved items. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Provide more meaningful error handling or logging
      print('Error fetching reserved items: $e');
      throw Exception('Failed to load reserved items');
    }
  }

  Future<List<Map<String, dynamic>>> getBestMeals() async {
    final ipAddress = await getLocalIPv4Address();
    final String apiUrl = "http://$ipAddress:3000/bestMeals";

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        // Parse the response body
        List<dynamic> data = json.decode(response.body);

        // Convert the list of dynamic to List<Map<String, dynamic>>
        List<Map<String, dynamic>> bestMeals =
            List<Map<String, dynamic>>.from(data);
        return bestMeals;
      } else {
        throw Exception(
            'Failed to load reserved items. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching best meals items: $e');
      throw Exception('Failed to load reserved items');
    }
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    double containerWidth1 = MediaQuery.of(context).size.width * 0.99;
    double containerHeight1 = MediaQuery.of(context).size.height * 0.2; //0.16
    double containerHeight2 = MediaQuery.of(context).size.height * 0.08; //0.22
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: appBarPage(slidepage: false, index: 0),
      ),
      backgroundColor: themeProvider.isDarkMode
          ? Color.fromARGB(255, 25, 25, 25)
          : Color(0xFFffffff).withOpacity(0.93),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            WhatDoYouWantToEat(
                containerHeight1: containerHeight1,
                containerHeight2: containerHeight2,
                containerWidth1: containerWidth1),
            Padding(
              padding:
                  const EdgeInsets.only(left: 8, right: 15, top: 8, bottom: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    S.of(context).Recently_added,
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: themeProvider.isDarkMode
                          ? Color(0xFFffffff)
                          : Color(0xFF000000),
                    ),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    S.of(context).view_all,
                    style: TextStyle(
                      fontSize: 18.0,
                      color: themeProvider.isDarkMode
                          ? Color(0xFFffffff)
                          : Color(0xFF000000).withOpacity(0.7),
                    ),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
            ),
            Container(
              height: 320,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: meals.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                      top: 12.0,
                      left: 20,
                      right: 10,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFffffff),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(50),
                          bottomLeft: Radius.circular(50),
                          topLeft: Radius.circular(50),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      height: 320,
                      width: 240,
                      child: Stack(
                        children: [
                          Positioned(
                            top: 0,
                            left: 0,
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(60),
                                //bottomLeft: Radius.circular(50),
                                topLeft: Radius.circular(60),
                                //bottomRight: Radius.circular(10),
                              ),
                              child:  Image.network(
                                      meals[index]["image"],
                                      height: 210,
                                      width: 245,
                                      fit: BoxFit.cover,
                                    )
                                  // : Image.file(
                                  //     File(meals[index]["image"]),
                                  //     height: 210,
                                  //     width: 245,
                                  //     fit: BoxFit.cover,
                                  //   ),
                            ),
                          ),
                          // SizedBox(height: 8),
                          Positioned(
                            bottom: 55,
                            // left: 20,
                            child: Container(
                              width: 150,
                              child: Text(
                                meals[index]["mealtitle"],
                                style: TextStyle(
                                  fontSize: 23,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 20,
                            // left: 20,
                            child: Container(
                              width: 150,
                              child: Text(
                                meals[index]["price"].toString() + "₪",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          //SizedBox(height: 8),
                          Positioned(
                            bottom: 30,
                            left: Intl.getCurrentLocale() == 'ar' ? 10 : null,
                            right: Intl.getCurrentLocale() == 'ar' ? null : 10,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => homeMadeDetails(
                                              idmeals: meals[index]["idmeals"],
                                              image: meals[index]["image"],
                                              mealtitle: meals[index]
                                                  ["mealtitle"],
                                              details: meals[index]["details"],
                                              count: meals[index]["count"],
                                              price: meals[index]["price"],
                                              leftOver: meals[index]
                                                  ["leftOver"],
                                            )));
                              },
                              child: Container(
                                height: 45,
                                width: 45,
                                decoration: BoxDecoration(
                                  color: Color(0xFF117a5d),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 40,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 20.0, bottom: 8),
              child: Text(
                S.of(context).best_seller,
                style: TextStyle(
                  fontSize: 26.0,
                  fontWeight: FontWeight.bold,
                  color: themeProvider.isDarkMode
                      ? Color(0xFFffffff)
                      : Color(0xFF000000),
                ),
                textAlign: TextAlign.left,
              ),
            ),
            ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: bestMeals.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                      left: 20.0,
                      right: 20.0,
                    ),
                    child: Container(
                      height: 120,
                      width: 360,
                      decoration: BoxDecoration(
                          color: Color(0xFFffffff),
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                            topLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          )),
                      child: Stack(
                        children: [
                          Positioned(
                            left: 0,
                            bottom: 0,
                            top: 0,
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  bottomLeft: Radius.circular(20)),
                              child:  Image.network(bestMeals[index]["image"],
                                      width: 150, fit: BoxFit.cover)
                                  // : Image.file(File(bestMeals[index]["image"]),
                                  //     width: 150, fit: BoxFit.cover),
                            ),
                          ),
                          Positioned(
                            left: 160,
                            top: 20,
                            child: Text(
                              bestMeals[index]["mealtitle"],
                              style: TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF000000),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Positioned(
                            bottom: 20,
                            left: 135,
                            child: Container(
                              width: 150,
                              child: Text(
                                bestMeals[index]["price"].toString() + "₪",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF000000),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          // SizedBox(height: 8),
                          Positioned(
                            bottom: 0,
                            right: kIsWeb ? null : 0,
                            left: kIsWeb ? 510 : null,
                            top: 0,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => homeMadeDetails(
                                              idmeals: bestMeals[index]
                                                  ["idmeals"],
                                              image: bestMeals[index]["image"],
                                              mealtitle: bestMeals[index]
                                                  ["mealtitle"],
                                              details: bestMeals[index]
                                                  ["details"],
                                              count: bestMeals[index]["count"],
                                              price: meals[index]["price"],
                                              leftOver: meals[index]
                                                  ["leftOver"],
                                            )));
                              },
                              child: Container(
                                height: 100,
                                width: 70,
                                decoration: BoxDecoration(
                                  color: Color(0xFF117a5d).withOpacity(0.8),
                                  borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(20),
                                      topRight: Radius.circular(20)),
                                ),
                                child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 50,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}
