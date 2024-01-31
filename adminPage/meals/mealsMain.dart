import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_project_1st/ipaddress.dart';
import 'package:http/http.dart' as http;

import 'addNewMeals.dart';
import 'editMeals.dart';

class mealsMain extends StatefulWidget {
  const mealsMain({super.key});

  @override
  State<mealsMain> createState() => _mealsMainState();
}

class _mealsMainState extends State<mealsMain> {
  List<Map<String, dynamic>> mealArray = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeData();
  }

  Future<void> initializeData() async {
    try {
      mealArray = await getOMeals();
      print('mealArray: $mealArray');

      if (mealArray.isNotEmpty) {
        setState(() {
          mealArray = mealArray;
        });
      }
    } catch (error) {
      // Provide more meaningful error handling or logging
      print('Error initializing data: $error');
    }
  }

  Future<List<Map<String, dynamic>>> getOMeals() async {
    final ipAddress = await getLocalIPv4Address();
    final String apiUrl = "http://$ipAddress:3000/getMeals";

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        // Parse the response body
        List<dynamic> data = json.decode(response.body);

        // Convert the list of dynamic to List<Map<String, dynamic>>
        List<Map<String, dynamic>> mealArray =
            List<Map<String, dynamic>>.from(data);
        return mealArray;
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

  Future<void> DeleteMeals({
    required String idmeals,
  }) async {
    final ipAddress = await getLocalIPv4Address();
    final url = Uri.parse('http://$ipAddress:3000/deleteMeals');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'idmeals': idmeals,
        },
      );

      if (response.statusCode == 200) {
        // Data sent successfully
        print('Meals deleted successfully');
        setState(() {});
      } else {
        print('HTTP error: ${response.statusCode}');
      }
    } catch (error) {
      // Handle network or other errors
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    double containerWidth = MediaQuery.of(context).size.width * 0.95;
    double containerHeight = MediaQuery.of(context).size.height * 0.4;
    return Scaffold(
      backgroundColor: Color(0xFFffffff),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "HomeMade Cooking",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => addNewMeals()));
                    },
                    child: Text(
                      "Add new meals",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                    style: TextButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      backgroundColor: Color(0xFF000000).withOpacity(
                          0.5), // Change background color (optional)
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(12), // Rounded corners
                      ),
                      // Add more styling as required
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: mealArray.length,
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
                          child: Image.network(
                            mealArray[index]["image"],
                            height: kIsWeb ? 420 : 340,
                            width: containerWidth,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          bottom: 15,
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              height: 280,
                              width: kIsWeb ? containerWidth * 0.95 : 340,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24),
                                color: Colors.white.withOpacity(0.9),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    Center(
                                      child: Text(
                                        "Meal Name: " +
                                            mealArray[index]["mealtitle"],
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Center(
                                      child: Text(
                                        "Price: " +
                                            mealArray[index]["price"]
                                                .toString() +
                                            "₪",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Center(
                                      child: Text(
                                        "Count: " +
                                            mealArray[index]["count"]
                                                .toString(),
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Center(
                                      child: Text(
                                        "LeftOver: " +
                                            mealArray[index]["leftOver"]
                                                .toString(),
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    Center(
                                      child: Text(
                                        "Details: " +
                                            mealArray[index]["details"],
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 4,
                          right: 4,
                          child: GestureDetector(
                            onTap: () {
                              _showBottomSheet(
                                context,
                                index,
                                mealArray[index]["idmeals"],
                                mealArray[index]["mealtitle"],
                                mealArray[index]["price"].toString(),
                                mealArray[index]["count"].toString(),
                                mealArray[index]["details"],
                                mealArray[index]["image"],
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24),
                                color: Colors.white.withOpacity(0.9),
                              ),
                              child: Icon(
                                Icons.more_vert,
                                //color: Colors.black87,
                                color: Colors.black87,
                                size: 30,
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
        ],
      ),
    );
  }

  void _showBottomSheet(
      BuildContext context,
      int index,
      int idmeals,
      String mealtitle,
      String price,
      String count,
      String details,
      String image) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0), // Adjust the radius as needed
            topRight: Radius.circular(20.0),
          ),
          child: Container(
            color: Color(0xFFffffff),
            //color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.edit,
                      size: 25,
                      color: Colors.black,
                    ),
                    title: Text(
                      "Edit",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => editMeals(
                                    idmeals: idmeals,
                                    mealtitle: mealtitle,
                                    price: price,
                                    count: count,
                                    details: details,
                                    image: image,
                                  )));
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.delete,
                      size: 25,
                      color: Colors.black,
                    ),
                    title: Text(
                      "Delete",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                    onTap: () async {
                      Navigator.pop(context);
                      _showDeleteConfirmationDialog(context, index, idmeals);
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showDeleteConfirmationDialog(
      BuildContext context, int index, int idmeals) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Delete Meal',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w700, fontSize: 24),
          ),
          content: Text(
            'Are you sure you want to delete this meal?',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w400, fontSize: 20),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text(
                'Cancel',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 20),
              ),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                await DeleteMeals(idmeals: idmeals.toString());
                setState(() {
                  mealArray.removeAt(index);
                });
              },
              child: Text(
                'Delete',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 20),
              ),
            ),
          ],
        );
      },
    );
  }
}
