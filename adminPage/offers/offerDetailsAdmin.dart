import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_project_1st/ipaddress.dart';
import 'package:flutter_project_1st/offers/offerAppBar.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart' show kIsWeb;

import 'addnewOffer.dart';
import 'editOfferDetails.dart';

class offerDetailsAdmin extends StatefulWidget {
  const offerDetailsAdmin({
    super.key,
    required this.offerDetailID,
  });
  final int offerDetailID;

  @override
  State<offerDetailsAdmin> createState() => _offerDetailsAdminState();
}

class _offerDetailsAdminState extends State<offerDetailsAdmin> {
  List<Map> offerdetails = [];
  @override
  void initState() {
    super.initState();
    initializeData();
  }

  Future<void> initializeData() async {
    try {
      offerdetails = await getOfferdetails(widget.offerDetailID.toString());
      print('offerdetails: $offerdetails');

      if (offerdetails.isNotEmpty) {
        setState(() {
          offerdetails = offerdetails;
        });
      }
    } catch (error) {
      // Provide more meaningful error handling or logging
      print('Error initializing data: $error');
    }
  }

  Future<List<Map>> getOfferdetails(String idofferNames) async {
    final ipAddress = await getLocalIPv4Address();
    final String apiUrl =
        "http://$ipAddress:3000/getOfferDetails/$idofferNames";

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        // Parse the response body
        List<dynamic> data = json.decode(response.body);

        // Convert the list of dynamic to List<Map<String, dynamic>>
        List<Map> offerdetails = List<Map>.from(data);
        return offerdetails;
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

  Future<void> DeleteOfferDetails({
    required String idofferdetails,
  }) async {
    final ipAddress = await getLocalIPv4Address();
    final url = Uri.parse('http://$ipAddress:3000/deleteofferDetails');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'idofferdetails': idofferdetails,
        },
      );

      if (response.statusCode == 200) {
        // Data sent successfully
        print('offer deleted successfully');
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
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Offers",
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
                              builder: (context) => addNewOffer(
                                    index: widget.offerDetailID,
                                  )));
                    },
                    child: Text(
                      "Add new offer",
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
            child: offerdetails.isEmpty
                ? Center(
                    child: Text(
                      "There are no offers to display yet",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: offerdetails.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          width: kIsWeb ? containerWidth * 0.95 : 320,
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
                                  offerdetails[index]["image"],
                                  height: containerHeight,
                                  width: containerWidth,
                                  fit: BoxFit.cover,
                                ),
                                // child: kIsWeb
                                //     ? Image.network(
                                //         offerdetails[index]["image"],
                                //         height: 380,
                                //         width: 320,
                                //         fit: BoxFit.cover,
                                //       )
                                //     : Image.file(
                                //         File(offerdetails[index]["image"]),
                                //         //'assets/offers/offer1.jpg',
                                //         height: containerHeight,
                                //         width: containerWidth,
                                //         fit: BoxFit.cover,
                                //       ),
                              ),
                              Positioned(
                                bottom: 15,
                                child: GestureDetector(
                                  onTap: () {
                                    // Handle offer item tap
                                  },
                                  child: Container(
                                    height: 80,
                                    width: containerWidth * 0.95,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(24),
                                      color: Colors.white.withOpacity(0.9),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Center(
                                          child: Text(
                                            offerdetails[index]
                                                ["offerdetailsName"],
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        Center(
                                          child: Text(
                                            offerdetails[index]["price"]
                                                    .toString() +
                                                "₪",
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ],
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
                                        offerdetails[index]["idofferdetails"],
                                        offerdetails[index]["image"],
                                        offerdetails[index]["price"].toString(),
                                        offerdetails[index]
                                            ["offerdetailsName"]);
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

  void _showBottomSheet(BuildContext context, int index, int idofferdetails,
      String offerImage, String offerPrice, String offerTitle) {
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
                              builder: (context) => editOfferDetails(
                                    idofferdetails: idofferdetails,
                                    offerImage: offerImage,
                                    offerPrice: offerPrice,
                                    offerTitle: offerTitle,
                                    index: widget.offerDetailID,
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
                          context, index, idofferdetails.toString());
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
      BuildContext context, int index, String idofferdetails) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Delete Offer Details',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w700, fontSize: 24),
          ),
          content: Text(
            'Are you sure you want to delete this offer details?',
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
                await DeleteOfferDetails(
                    idofferdetails: idofferdetails.toString());
                setState(() {
                  offerdetails.removeAt(index);
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
