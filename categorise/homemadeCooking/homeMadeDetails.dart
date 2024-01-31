import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:flutter_project_1st/categorise/appbar_details.dart';
import 'package:flutter_project_1st/generated/l10n.dart';
import 'package:flutter_project_1st/ipaddress.dart';
import 'package:flutter_project_1st/settingpage/theme/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;


import 'checkout.dart';
import 'screens/recipe_screen.dart';

class homeMadeDetails extends StatefulWidget {
  const homeMadeDetails(
      {Key? key,
      required this.idmeals,
      required this.image,
      required this.mealtitle,
      required this.count,
      required this.details,
      required this.price,
      required this.leftOver})
      : super(key: key);
  final int idmeals;
  final String image;
  final String mealtitle;
  final int count;
  final String details;
  final int price;
  final int leftOver;

  @override
  State<homeMadeDetails> createState() => _homeMadeDetailsState();
}

class _homeMadeDetailsState extends State<homeMadeDetails> {
  int mealCount = 1;
  List<Map<String, dynamic>> reviews = [];
  Future<List<Map<String, dynamic>>> showReviewItem(String idmeal) async {
    final ipAddress = await getLocalIPv4Address();
    final String apiUrl = "http://$ipAddress:3000/showReviewItem/$idmeal";

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        // Parse the response body
        List<dynamic> data = json.decode(response.body);

        // Convert the list of dynamic to List<Map<String, dynamic>>
        List<Map<String, dynamic>> reviews =
            List<Map<String, dynamic>>.from(data);
        return reviews;
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

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    double containerHeight1 = MediaQuery.of(context).size.height * 0.38;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: appBarDetails(gotoFav: false),
      ),
      backgroundColor: themeProvider.isDarkMode
          ? Color.fromARGB(255, 37, 37, 37).withOpacity(0.3)
          : Color(0xFFffffff),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: double.infinity,
                height: containerHeight1,
                decoration: BoxDecoration(
                  color: const Color(0xFF117a5d),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.elliptical(150.0, 150.0),
                    bottomRight: Radius.elliptical(150.0, 150.0),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.elliptical(150.0, 150.0),
                    bottomRight: Radius.elliptical(150.0, 150.0),
                  ),
                  child:  Image.network(
                          widget.image,
                          fit: BoxFit.cover,
                        )
                      // : Image.file(
                      //     File(widget.image),
                      //     fit: BoxFit.cover,
                      //   ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              widget.mealtitle,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: themeProvider.isDarkMode ? Colors.white : Colors.black,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Color(0xFF117a5d),
                      // padding: EdgeInsets.all(20),
                      fixedSize: Size(150, 50)),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RecipeScreen(
                                  image: widget.image,
                                  idmeal: widget.idmeals,
                                  mealName: widget.mealtitle,
                                  count: widget.count,
                                  leftOver: widget.leftOver,
                                )));
                  },
                  child: Text(
                    S.of(context).Details,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 20),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Color(0xFFffffff),
                      // padding: EdgeInsets.all(20),
                      fixedSize: Size(150, 50)),
                  onPressed: () async {
                    // Handle Review button press
                    reviews = await showReviewItem(widget.idmeals.toString());
                    showReview(widget.idmeals.toString());
                  },
                  child: Text(
                    S.of(context).Review,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Text(
              widget.details,
              style: TextStyle(
                fontSize: 18,
                color: themeProvider.isDarkMode ? Colors.white : Colors.black,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              //color: Color(0xFF117a5d),
                            ),
                            padding: const EdgeInsets.all(1),
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  if (mealCount > 1) {
                                    mealCount--;
                                  }
                                });
                              },
                              icon: Icon(
                                Icons.remove,
                                size: 35,
                              ),
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 16),
                      Text(
                        '$mealCount',
                        style: TextStyle(
                            fontSize: 24,
                            color: Colors.black,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(width: 16),
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          //color: Color(0xFF117a5d),
                        ),
                        padding: const EdgeInsets.all(1),
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              mealCount++;
                            });
                          },
                          icon: Icon(
                            Icons.add,
                            size: 35,
                          ),
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Color(0xFF117a5d),
                      // padding: EdgeInsets.all(20),
                      fixedSize: Size(170, 70)),
                  onPressed: () {
                    // Handle Details button press
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CheckoutPage(
                                  count: mealCount,
                                  image: widget.image,
                                  mealName: widget.mealtitle,
                                  idmeal: widget.idmeals,
                                  price: widget.price,
                                )));
                  },
                  child: Text(
                    S.of(context).order_now,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 24),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //***************************SHOW REVIEW************************************//
  void showReview(String idmeal) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Dialog(
              child: Stack(
                children: [
                  Container(
                    width: 350,
                    height: 480,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Reviews",
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold)),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: reviews.length,
                              itemBuilder: (context, index) {
                                return buildReviewRow(reviews[index]);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey.shade200,
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.close,
                          color: Colors.black,
                          size: 30,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the dialog.
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget buildReviewRow(Map<String, dynamic> review) {
    int colorIcon = review['review'];
    return Row(
      children: [
        CircleAvatar(
          radius: 20,
          child: ClipOval(
            child: Image.network(
                    review['profileimage'],
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  )
                // : Image.file(
                //     File(review['profileimage']),
                //     fit: BoxFit.cover,
                //     width: double.infinity,
                //     height: double.infinity,
                //   ),
          ),
        ),
        SizedBox(width: 15, height: 8),
        Padding(
          padding: const EdgeInsets.all(6.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                review['Fname'] + " " + review['Lname'],
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              Row(
                children: [
                  Icon(
                    Icons.sentiment_very_dissatisfied,
                    color: colorIcon == 1 ? Color(0xFFBFA100) : Colors.black54,
                    size: 28,
                  ),
                  Icon(
                    Icons.sentiment_dissatisfied,
                    color: colorIcon == 2 ? Color(0xFFBFA100) : Colors.black54,
                    size: 28,
                  ),
                  Icon(
                    Icons.sentiment_neutral,
                    color: colorIcon == 3 ? Color(0xFFBFA100) : Colors.black54,
                    size: 28,
                  ),
                  Icon(
                    Icons.sentiment_satisfied,
                    color: colorIcon == 4 ? Color(0xFFBFA100) : Colors.black54,
                    size: 28,
                  ),
                  Icon(
                    Icons.sentiment_very_satisfied,
                    color: colorIcon == 5 ? Color(0xFFBFA100) : Colors.black54,
                    size: 28,
                  ),
                ],
              ),
              Container(
                width: 220,
                child: Text(
                  review['comment'],
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                    color: Colors.black54,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
