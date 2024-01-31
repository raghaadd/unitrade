import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_project_1st/generated/l10n.dart';
import 'package:flutter_project_1st/ipaddress.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:location/location.dart';

class addNewMarket extends StatefulWidget {
  const addNewMarket({super.key, required this.offerCategory});
  final int offerCategory;

  @override
  State<addNewMarket> createState() => _addNewMarketState();
}

class _addNewMarketState extends State<addNewMarket> {
  final TextEditingController _itemnameController = TextEditingController();
  final TextEditingController _discount = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _location = TextEditingController();
  final TextEditingController _details = TextEditingController();

  String lang_lat = "Location";

  Future<void> AddNewMarketinfo({
    required String idoffers,
    required String offerDetails,
    required String discount,
    required String phoneNumber,
    required String location,
    required String details,
  }) async {
    final ipAddress = await getLocalIPv4Address();
    final url = Uri.parse('http://$ipAddress:3000/addNewMarket');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'idoffers': idoffers,
          'offerDetails': offerDetails,
          'discount': discount,
          'phoneNumber': phoneNumber,
          'location': location,
          'details': details,
        },
      );

      if (response.statusCode == 200) {
        // Data sent successfully
        print('new market added successfully');
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
    return Scaffold(
      backgroundColor: Color(0xFFffffff),
      body: Container(
        padding: EdgeInsets.only(left: 15, top: 30, right: 15),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              TextField(
                controller: _itemnameController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: "Offer Name",
                  hintStyle: TextStyle(
                    color: Colors.black,
                  ),
                ),
                style: TextStyle(
                  color: Colors.black, // Set your desired text color here
                ),
              ),
              SizedBox(
                height: 18,
              ),
              TextField(
                controller: _phoneNumber,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: "Phone Number",
                  hintStyle: TextStyle(
                    color: Colors.black,
                  ),
                ),
                style: TextStyle(
                  color: Colors.black, // Set your desired text color here
                ),
              ),
              SizedBox(
                height: 18,
              ),
              TextField(
                controller: _discount,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: "Discount",
                  hintStyle: TextStyle(
                    color: Colors.black,
                  ),
                ),
                style: TextStyle(
                  color: Colors.black, // Set your desired text color here
                ),
              ),
              SizedBox(
                height: 18,
              ),
              TextField(
                controller: _location,
                keyboardType: TextInputType.streetAddress,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: lang_lat,
                  hintStyle: TextStyle(
                    color: Colors.black,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.map),
                    onPressed: () async {
                      // Your existing onTap logic
                      print("locationnnn********************");
                      String location = _location.text;
                      if (await canLaunch(
                          'https://www.google.com/maps/search/?api=1&query=$location')) {
                        await launch(
                            'https://www.google.com/maps/search/?api=1&query=$location');
                      } else {
                        // Handle unable to launch URL
                      }

                      // Get latitude and longitude
                      LocationData? currentLocation = await _getLocation();
                      if (currentLocation != null) {
                        print(
                            'Latitude: ${currentLocation.latitude}, Longitude: ${currentLocation.longitude}');
                        setState(() {
                          lang_lat = currentLocation.latitude.toString() +
                              "," +
                              currentLocation.latitude.toString();
                        });

                        // You can save these values as needed
                      } else {
                        // Handle location not available
                      }
                    },
                  ),
                ),
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 18,
              ),
              TextField(
                controller: _details,
                maxLines: 3,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: S.of(context).Details,
                  hintStyle: TextStyle(
                    color: Colors.black,
                  ),
                ),
                style: TextStyle(
                  color: Colors.black, // Set your desired text color here
                ),
              ),
              SizedBox(
                height: 18,
              ),
              Row(
                mainAxisAlignment: kIsWeb
                    ? MainAxisAlignment.spaceEvenly
                    : MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      S.of(context).Cancel,
                      style: TextStyle(
                        fontSize: 20,
                        letterSpacing: 2,
                        color: Colors.black,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      AddNewMarketinfo(
                          idoffers: widget.offerCategory.toString(),
                          offerDetails: _itemnameController.text,
                          details: _details.text,
                          phoneNumber: _phoneNumber.text,
                          discount: _discount.text,
                          location: lang_lat);
                      Navigator.pop(context);
                      Navigator.pop(context);
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) =>
                      //             offerNames(offerCategory: widget.index)));
                    },
                    child: Text(
                      S.of(context).Save,
                      style: TextStyle(
                          fontSize: 20, letterSpacing: 2, color: Colors.white),
                    ),
                    style: OutlinedButton.styleFrom(
                        backgroundColor: Color(0xFF117a5d),
                        padding: EdgeInsets.symmetric(horizontal: 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<LocationData?> _getLocation() async {
    Location location = Location();
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return null;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    return await location.getLocation();
  }
}
