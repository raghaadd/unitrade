import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_project_1st/ipaddress.dart';
import 'package:http/http.dart' as http;

class feedbackMain extends StatefulWidget {
  const feedbackMain({super.key});

  @override
  State<feedbackMain> createState() => _feedbackMainState();
}

class _feedbackMainState extends State<feedbackMain> {
  List<Map<String, dynamic>> feedbackArray = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeData();
  }

  Future<void> initializeData() async {
    try {
      feedbackArray = await getFeedback();
      print('mealArray: $feedbackArray');

      if (feedbackArray.isNotEmpty) {
        setState(() {
          feedbackArray = feedbackArray;
        });
      }
    } catch (error) {
      // Provide more meaningful error handling or logging
      print('Error initializing data: $error');
    }
  }

  Future<List<Map<String, dynamic>>> getFeedback() async {
    final ipAddress = await getLocalIPv4Address();
    final String apiUrl = "http://$ipAddress:3000/getFeedback";

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        // Parse the response body
        List<dynamic> data = json.decode(response.body);

        // Convert the list of dynamic to List<Map<String, dynamic>>
        List<Map<String, dynamic>> feedbackArray =
            List<Map<String, dynamic>>.from(data);
        return feedbackArray;
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
    return Scaffold(
      backgroundColor: Color(0xFFffffff),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 15,
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: feedbackArray.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    width: kIsWeb ? 620 : 340,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color: Colors.white,
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(24),
                            child: Container(
                              color: Color(0xFF0b6e4f).withOpacity(0.75),
                              height: kIsWeb ? 320 : 300,
                              width: kIsWeb ? 420 : 350,
                              child: Column(
                                children: [
                                  Text(
                                    "،،",
                                    style: TextStyle(
                                        fontSize: 60,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    feedbackArray[index]["feedbackcomment"],
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    feedbackArray[index]["feedbacknumber"]
                                            .toString() +
                                        "/5",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.grey.shade300,
                                    child: ClipOval(
                                        child: Image.network(
                                      feedbackArray[index]["profileimage"],
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: double.infinity,
                                    )),
                                  ),
                                  Text(
                                    feedbackArray[index]["fname"] +
                                        " " +
                                        feedbackArray[index]["lname"],
                                    style: TextStyle(
                                      fontSize: 16,
                                      // fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            )),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
