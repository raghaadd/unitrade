import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_project_1st/generated/l10n.dart';
import 'package:flutter_project_1st/ipaddress.dart';
import 'package:flutter_project_1st/registerID.dart';
import 'package:flutter_project_1st/settingpage/theme/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class loyaltyPoints extends StatefulWidget {
  const loyaltyPoints({super.key});

  @override
  State<loyaltyPoints> createState() => _loyaltyPointsState();
}

class _loyaltyPointsState extends State<loyaltyPoints> {
  @override
  void initState() {
    super.initState();
    initializeData();
  }

  String solditems = "0";
  String discount = "0%";
  List<Map<String, dynamic>> reviews = [];

  Future<void> initializeData() async {
    try {
      final userData = Provider.of<UserData>(context, listen: false);
      final registerID = userData.registerID;
      solditems = await fetchSoldItems(registerID);
      print(solditems);
      setState(() {
        if (solditems == "null") {
          solditems = "0";
        } else {
          solditems = solditems;
        }
        int intsolditems = int.parse(solditems);
        if (intsolditems > 10) {
          discount = "10%";
        }
      });
      reviews = await showMYReview(registerID);
      setState(() {
        reviews = reviews;
      });
    } catch (error) {
      // Handle errors
      print('Error initializing data: $error');
    }
  }

  Future<String> fetchSoldItems(String registerID) async {
    final ipAddress = await getLocalIPv4Address();
    final response = await http
        .get(Uri.parse('http://$ipAddress:3000/solditems/$registerID'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['saleCounter'].toString();
    } else {
      throw Exception('Failed to get sold items');
    }
  }

  Future<List<Map<String, dynamic>>> showMYReview(
      String original_userID) async {
    final ipAddress = await getLocalIPv4Address();
    final String apiUrl =
        "http://$ipAddress:3000/showMYReview/$original_userID";

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
    return Scaffold(
      backgroundColor: themeProvider.isDarkMode ? Colors.black87 : Colors.white,
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(30.0),
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color:
                  themeProvider.isDarkMode ? Colors.black45 : Colors.grey[300],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      S.of(context).Sold_items,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: themeProvider.isDarkMode
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                    Text(
                      solditems,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: themeProvider.isDarkMode
                            ? Colors.white
                            : Colors.black,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      S.of(context).Discount,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: themeProvider.isDarkMode
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                    Text(
                      discount,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: themeProvider.isDarkMode
                            ? Colors.white
                            : Colors.black,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(30.0),
          child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: themeProvider.isDarkMode
                    ? Colors.black45
                    : Colors.grey[300],
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //SizedBox(height: 40),
                    Text(
                      S.of(context).Ratings_reviews,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: themeProvider.isDarkMode
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                    SizedBox(height: 10),
                    reviews.isEmpty
                        ? Text(
                            'No reviews to display',
                            style: TextStyle(
                              fontSize: 18,
                              color: themeProvider.isDarkMode
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          )
                        : SizedBox(height: 10),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: reviews.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            buildReviewRow(reviews[index], themeProvider),
                            Divider(
                              thickness: 3,
                              color: themeProvider.isDarkMode
                                  ? Colors.white
                                  : Colors.black26,
                            ),
                          ],
                        );
                      },
                    ),
                  ])),
        )
      ]),
    );
  }

  Widget buildReviewRow(
      Map<String, dynamic> review, ThemeProvider themeProvider) {
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
                  color: themeProvider.isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              Row(
                children: [
                  Icon(
                    Icons.sentiment_very_dissatisfied,
                    color: colorIcon == 1
                        ? Color(0xFFBFA100)
                        : themeProvider.isDarkMode
                            ? Colors.white
                            : Colors.black54,
                    size: 28,
                  ),
                  Icon(
                    Icons.sentiment_dissatisfied,
                    color: colorIcon == 2
                        ? Color(0xFFBFA100)
                        : themeProvider.isDarkMode
                            ? Colors.white
                            : Colors.black54,
                    size: 28,
                  ),
                  Icon(
                    Icons.sentiment_neutral,
                    color: colorIcon == 3
                        ? Color(0xFFBFA100)
                        : themeProvider.isDarkMode
                            ? Colors.white
                            : Colors.black54,
                    size: 28,
                  ),
                  Icon(
                    Icons.sentiment_satisfied,
                    color: colorIcon == 4
                        ? Color(0xFFBFA100)
                        : themeProvider.isDarkMode
                            ? Colors.white
                            : Colors.black54,
                    size: 28,
                  ),
                  Icon(
                    Icons.sentiment_very_satisfied,
                    color: colorIcon == 5
                        ? Color(0xFFBFA100)
                        : themeProvider.isDarkMode
                            ? Colors.white
                            : Colors.black54,
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
                    color: themeProvider.isDarkMode
                        ? Colors.white
                        : Colors.black54,
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
