import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_project_1st/ipaddress.dart';
import 'package:flutter_project_1st/offers/offerAppBar.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:http/http.dart' as http;

import 'addNewMarket.dart';
import 'editMarket.dart';
import 'offerDetailsAdmin.dart';

class offerNames extends StatefulWidget {
  const offerNames({super.key, required this.offerCategory});
  final int offerCategory;

  @override
  State<offerNames> createState() => _offerNamesState();
}

class _offerNamesState extends State<offerNames> {
  List<Map<String, dynamic>> offerArray = [];
  List<Map> offers = [
    {
      "name": "Electronics",
      "image": 'assets/offers/offer1.jpg',
    },
    {
      "name": "Electricals",
      "image": 'assets/offers/offer2.jpg',
    },
    {
      "name": "Furnitures",
      "image": 'assets/offers/offer3.jpg',
    },
    {
      "name": "Restaurants",
      "image": "assets/resturants/rest4.jpeg",
    },
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeData();
  }

  Future<void> initializeData() async {
    try {
      offerArray = await getOffers4(widget.offerCategory.toString());
      print('offer1Array: $offerArray');

      if (offerArray.isNotEmpty) {
        setState(() {
          offerArray = offerArray;
        });
      }
    } catch (error) {
      // Provide more meaningful error handling or logging
      print('Error initializing data: $error');
    }
  }

  Future<List<Map<String, dynamic>>> getOffers4(String idoffers) async {
    final ipAddress = await getLocalIPv4Address();
    final String apiUrl = "http://$ipAddress:3000/getOffers/$idoffers";

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        // Parse the response body
        List<dynamic> data = json.decode(response.body);

        // Convert the list of dynamic to List<Map<String, dynamic>>
        List<Map<String, dynamic>> offerArray =
            List<Map<String, dynamic>>.from(data);
        return offerArray;
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

  Future<void> DeleteMarketDetails({
    required String idofferNames,
  }) async {
    final ipAddress = await getLocalIPv4Address();
    final url = Uri.parse('http://$ipAddress:3000/deleteMarketDetails');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'idofferNames': idofferNames,
        },
      );

      if (response.statusCode == 200) {
        // Data sent successfully
        print('Market deleted successfully');
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
    double containerWidth = MediaQuery.of(context).size.width * 0.98;
    double containerHeight = MediaQuery.of(context).size.height * 0.4;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: appBarOffers(),
      ),
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
                    offers[widget.offerCategory - 1]["name"],
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
                              builder: (context) => addNewMarket(
                                    offerCategory: widget.offerCategory,
                                  )));
                    },
                    child: Text(
                      "Add new " + offers[widget.offerCategory - 1]["name"],
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
              itemCount: offerArray.length,
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
                          child: Image.asset(
                            offers[widget.offerCategory - 1]["image"],
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
                                        "Offer Name: " +
                                            offerArray[index]["offerDetails"],
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
                                        "Discount: " +
                                            offerArray[index]["discount"]
                                                .toString() +
                                            "%",
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
                                        "Phone Number: " +
                                            offerArray[index]["phoneNumber"]
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
                                        "Location: " +
                                            offerArray[index]["location"]
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
                                        "Details: " +
                                            offerArray[index]["details"],
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
                                  offerArray[index]["idofferNames"].toString(),
                                  offerArray[index]["offerDetails"],
                                  offerArray[index]["details"],
                                  offerArray[index]["discount"].toString(),
                                  offerArray[index]["location"].toString(),
                                  offerArray[index]["phoneNumber"].toString());
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
      String idofferNames,
      String offerDetails,
      String details,
      String discount,
      String location,
      String phoneNumber) {
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
                  padding: const EdgeInsets.only(left: 8.0, top: 18),
                  child: ListTile(
                    leading: Icon(
                      Icons.details,
                      size: 25,
                      color: Colors.black,
                    ),
                    title: Text(
                      "Offer details",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                    onTap: () async {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => offerDetailsAdmin(
                                    offerDetailID: offerArray[index]
                                        ["idofferNames"],
                                  )));
                    },
                  ),
                ),
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
                              builder: (context) => editMarket(
                                    idofferNames: idofferNames.toString(),
                                    offerDetails: offerDetails,
                                    details: details,
                                    discount: discount,
                                    location: location,
                                    phoneNumber: phoneNumber,
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
                      _showDeleteConfirmationDialog(
                          context, index, idofferNames);
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
      BuildContext context, int index, String idofferNames) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Delete Offer',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w700, fontSize: 24),
          ),
          content: Text(
            'Are you sure you want to delete this offer?',
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
                await DeleteMarketDetails(
                    idofferNames: idofferNames.toString());
                setState(() {
                  offerArray.removeAt(index);
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
