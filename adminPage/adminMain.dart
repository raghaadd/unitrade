import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_1st/adminPage/charts/pie_chart_status.dart';
import 'package:flutter_project_1st/adminPage/charts/pie_data.dart';
import 'package:flutter_project_1st/adminPage/charts/pie_status.dart';
import 'package:flutter_project_1st/ipaddress.dart';
import 'package:http/http.dart' as http;

import 'charts/indicator_status.dart';
import 'charts/indicator_widget.dart';
import 'charts/pie_chart_section.dart';

class adminMain extends StatefulWidget {
  const adminMain({super.key});

  @override
  State<adminMain> createState() => _adminMainState();
}

class _adminMainState extends State<adminMain> {
  String totalItems = '';
  String totalFeedback = '';
  String totalReport = '';
  String totalMeals = '';
  String totalUsers = '';
  String totalSoldItem = '';
  List<Map<String, dynamic>> feedbackArray = [];
  double avrageFeedback = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeData();
  }

  Future<void> initializeData() async {
    try {
      totalItems = await fetchTotalItems();
      totalFeedback = await fetchTotalFeedback();
      totalReport = await fetchTotalReport();
      totalUsers = await fetchTotalUsers();
      totalMeals = await fetchTotalMeals();
      totalSoldItem = await fetchTotalSoldItems();
      avrageFeedback = await calculateAverageFeedback();
      setState(() {
        totalItems = totalItems;
        avrageFeedback = avrageFeedback;
      });
    } catch (error) {
      // Provide more meaningful error handling or logging
      print('Error initializing data: $error');
    }
  }

  Future<String> fetchTotalItems() async {
    final ipAddress = await getLocalIPv4Address();
    final response =
        await http.get(Uri.parse('http://$ipAddress:3000/getTotalitem'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['total_item'].toString();
    } else {
      throw Exception('Failed to get sold items');
    }
  }

  Future<String> fetchTotalFeedback() async {
    final ipAddress = await getLocalIPv4Address();
    final response =
        await http.get(Uri.parse('http://$ipAddress:3000/getTotalfeedback'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['total_feedback'].toString();
    } else {
      throw Exception('Failed to get sold items');
    }
  }

  Future<double> calculateAverageFeedback() async {
    List<Map<String, dynamic>> feedbackData = await getFeedback();

    if (feedbackData.isEmpty) {
      // Handle the case when there is no feedback data
      return 0.0;
    }

    // Calculate the sum of feedback numbers
    int totalFeedbackNumber = feedbackData
        .map((feedback) => feedback['feedbacknumber'] as int)
        .reduce((value, element) => value + element);

    // Calculate the average feedback number
    double averageFeedback = totalFeedbackNumber / feedbackData.length;

    // Return the average feedback as a double
    return double.parse(averageFeedback.toStringAsFixed(1));
  }

  Future<String> fetchTotalReport() async {
    final ipAddress = await getLocalIPv4Address();
    final response =
        await http.get(Uri.parse('http://$ipAddress:3000/getTotalReport'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['total_report'].toString();
    } else {
      throw Exception('Failed to get sold items');
    }
  }

  Future<String> fetchTotalUsers() async {
    final ipAddress = await getLocalIPv4Address();
    final response =
        await http.get(Uri.parse('http://$ipAddress:3000/gettotalUsers'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['total_user'].toString();
    } else {
      throw Exception('Failed to get sold items');
    }
  }

  Future<String> fetchTotalMeals() async {
    final ipAddress = await getLocalIPv4Address();
    final response =
        await http.get(Uri.parse('http://$ipAddress:3000/gettotalMeals'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['total_meal'].toString();
    } else {
      throw Exception('Failed to get sold items');
    }
  }

  Future<String> fetchTotalSoldItems() async {
    final ipAddress = await getLocalIPv4Address();
    final response =
        await http.get(Uri.parse('http://$ipAddress:3000/gettotalSoldItems'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['total_sold_item'].toString();
    } else {
      throw Exception('Failed to get sold items');
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
    double containerWidth = MediaQuery.of(context).size.width * 0.97;
    final PieData pieData = PieData();
    final PieStatus piestatus = PieStatus();
    //double containerWidth1 = MediaQuery.of(context).size.width * 0.9;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                width: containerWidth,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xFF0b6e4f).withOpacity(0.8),
                  //color: Color(0xFF000000).withOpacity(0.6),
                ),
                child: Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween, // Space between items
                  children: [
                    Text(
                      " App Rating",
                      style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        avrageFeedback.toString() + "/5",
                        style: TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  color: Colors.black26,
                  width: containerWidth,
                  child: Text(
                    "Items Percentage:",
                    style: TextStyle(
                        fontSize: 22,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                )),
            FutureBuilder(
              future:
                  pieData.getPercentage().then((_) => pieData.initializeData()),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Center(
                    child: Container(
                      width: 210, // Set your desired width
                      height: 210, // Set your desired height
                      color: Colors.white,
                      child: PieChart(PieChartData(
                        borderData: FlBorderData(show: false),
                        sectionsSpace: 0,

                        centerSpaceRadius: 55,
                        sections:
                            getSections(PieData.data), // Pass the data here
                      )),
                    ),
                  );
                } else {
                  // Show loading indicator while data is fetching
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: IndicatorWidget(),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  color: Colors.black26,
                  width: containerWidth,
                  child: Text(
                    "Item Status:",
                    style: TextStyle(
                        fontSize: 22,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                )),
            FutureBuilder(
              future: piestatus
                  .getPercentage()
                  .then((_) => piestatus.initializeData()),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Center(
                    child: Container(
                      width: 210, // Set your desired width
                      height: 210, // Set your desired height
                      color: Colors.white,
                      child: PieChart(PieChartData(
                        borderData: FlBorderData(show: false),
                        sectionsSpace: 0,

                        centerSpaceRadius: 55,
                        sections:
                            getStatus(PieStatus.data), // Pass the data here
                      )),
                    ),
                  );
                } else {
                  // Show loading indicator while data is fetching
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: IndicatorStatus(),
                )
              ],
            ),
            Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  color: Colors.black26,
                  width: containerWidth,
                  child: Text(
                    "Number Summary:",
                    style: TextStyle(
                        fontSize: 22,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                )),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                //height: 60,
                width: containerWidth,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  //color: Color(0xFF000000).withOpacity(0.6),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween, // Space between items
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            "Total items",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            totalItems,
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      color: Colors.black,
                    ),
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween, // Space between items
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            "Total sold items",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            totalSoldItem,
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      color: Colors.black,
                    ),
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween, // Space between items
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            "Total number of users",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            totalUsers,
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      color: Colors.black,
                    ),
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween, // Space between items
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            "Total number of meals",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            totalMeals,
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      color: Colors.black,
                    ),
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween, // Space between items
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            "Total number of feedback",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            totalFeedback,
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      color: Colors.black,
                    ),
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween, // Space between items
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            "Total number of report",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            totalReport,
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
