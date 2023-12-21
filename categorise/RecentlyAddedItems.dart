import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_project_1st/additems/clicktoAdditem.dart';
import 'package:flutter_project_1st/categorise/furniturepage/furniture_details.dart';
import 'package:flutter_project_1st/generated/l10n.dart';
import 'package:flutter_project_1st/ipaddress.dart';
import 'package:flutter_project_1st/registerID.dart';
import 'package:flutter_project_1st/settingpage/theme/theme_provider.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'dart:convert';

import 'package:provider/provider.dart';

class RecentlyaddedItems extends StatefulWidget {
  const RecentlyaddedItems({
    Key? key,
    required this.array,
    required this.indexx,
  }) : super(key: key);

  final List<Map> array;
  final int indexx;

  @override
  State<RecentlyaddedItems> createState() => _RecentlyaddedItemsState();
}

class _RecentlyaddedItemsState extends State<RecentlyaddedItems> {
  List<Map> Furnitures = [];
  bool isFavoritee = false;
  bool isReservedd = false;
  final Map<String, Widget Function(int, List<Map>, bool, bool)>
      categoryDetailPages = {
    "Slides": (itemId, furnitures, isFavorite, isReserved) => FurnitureDetails(
        itemId: itemId,
        Furnitures: furnitures,
        isFavorite: isFavorite,
        isReserved: isReserved,
        showNavBar: true,
        gotoFav: false),
    "Books": (itemId, furnitures, isFavorite, isReserved) => FurnitureDetails(
        itemId: itemId,
        Furnitures: furnitures,
        isFavorite: isFavorite,
        isReserved: isReserved,
        showNavBar: true,
        gotoFav: false),
    "Electronic": (itemId, furnitures, isFavorite, isReserved) =>
        FurnitureDetails(
            itemId: itemId,
            Furnitures: furnitures,
            isFavorite: isFavorite,
            isReserved: isReserved,
            showNavBar: true,
            gotoFav: false),
    "Furniture": (itemId, furnitures, isFavorite, isReserved) =>
        FurnitureDetails(
            itemId: itemId,
            Furnitures: furnitures,
            isFavorite: isFavorite,
            isReserved: isReserved,
            showNavBar: true,
            gotoFav: false),
    // Add other categories and their corresponding detail pages here
  };

  List<Map> categories = [
    {
      "name": "Slides",
      "icon": Icons.book,
    },
    {
      "name": "Books",
      "icon": Icons.book,
    },
    {
      "name": "Electronic",
      "icon": Icons.phone,
    },
    {
      "name": "Furniture",
      "icon": Icons.chair,
    },
  ];

  @override
  void initState() {
    fetchDataFromAPI(); // Call the method to fetch data
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> fetchDataFromAPI() async {
    // Replace with your API endpoint
    final ipAddress = await getLocalIPv4Address();
    print(ipAddress);
    final response =
        await http.get(Uri.parse('http://$ipAddress:3000/furniturdetails'));
    if (response.statusCode == 200) {
      print(response.statusCode);
      final List<dynamic> data = jsonDecode(response.body);
      setState(() {
        Furnitures = data.map((furniture) {
          return {
            "id": furniture["iditem"],
            "image": furniture["image"],
            "title": furniture["title"],
            "category": furniture["CategoryName"],
            "status": furniture["status"],
            "Date": furniture["date"],
            "phoneNumber": furniture["phoneNumber"],
            "price": furniture["price"],
            "description": furniture["description"],
            "Fname": furniture["Fname"],
            "Lname": furniture["Lname"],
            "registerID": furniture["registerID"],
          };
        }).toList();
        //print("Furniture Data: $Furnitures");
      });
    } else {
      // Handle API error
      print('Failed to load furniture details');
    }
  }

  Future<bool> checkFavorite(int itemId, int registerId) async {
    final ipAddress = await getLocalIPv4Address();
    print(ipAddress);
    final apiUrl = 'http://$ipAddress:3000/checkFavorite/$itemId/$registerId';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return data['isFavorite'];
      } else {
        // Handle error
        print('Error: ${response.statusCode}');
        return false;
      }
    } catch (error) {
      // Handle exceptions
      print('Exception: $error');
      return false;
    }
  }

  Future<bool> checkReserved(int itemId, int registerId) async {
    final ipAddress = await getLocalIPv4Address();
    print(ipAddress);
    final apiUrl = 'http://$ipAddress:3000/checkReserved/$itemId/$registerId';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return data['isReserved'];
      } else {
        // Handle error
        print('Error: ${response.statusCode}');
        return false;
      }
    } catch (error) {
      // Handle exceptions
      print('Exception: $error');
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final userData = Provider.of<UserData>(context);
    final registerID = int.parse(userData.registerID);
    double containerWidth = MediaQuery.of(context).size.width * 0.75;
    double containerWidth1 = MediaQuery.of(context).size.width * 0.9;
    double containerHeight = MediaQuery.of(context).size.height * 0.12;
    double containerHeight1 = MediaQuery.of(context).size.height * 0.12; //0.16
    double containerHeight2 = MediaQuery.of(context).size.height * 0.15; //0.22
    return Column(
      children: [
        clicktoAddItem(
            containerHeight1: containerHeight1,
            containerWidth1: containerWidth1,
            containerHeight2: containerHeight2,
            slidepage: false),
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                S.of(context).Recently_added,
                style: TextStyle(
                  fontSize: 22.0,
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
        const SizedBox(height: 20),
        Expanded(
          child: widget.array.isEmpty
              ? Center(
                  // Display a message when the array is empty
                  child: Text(
                    S.of(context).Message_No_item,
                    style: TextStyle(fontSize: 20),
                  ),
                )
              : ListView.builder(
                  itemCount: widget.array.length,
                  itemBuilder: (context, index) {
                    final result = widget.array[index];
                    final category = categories[widget.indexx];
                    // Adjust as needed

                    return Row(
                      children: [
                        Intl.getCurrentLocale() == 'ar'
                            ? Container(
                                margin: EdgeInsets.only(
                                  bottom: 30,
                                  right: 8,
                                ),
                                decoration: const BoxDecoration(
                                  color: Color(0xFFffffff),
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(30),
                                    bottomRight: Radius.circular(30),
                                  ),
                                ),
                                height:
                                    containerHeight, // Adjust based on screen size
                                width:
                                    containerWidth, // Adjust based on screen size
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: ListTile(
                                    leading: ClipRRect(
                                      borderRadius: BorderRadius.circular(30),
                                      child: Image.file(
                                        File(
                                          result["image"],
                                        ),
                                        width: 120,
                                        height: 100,
                                        fit: BoxFit.cover,
                                      ),
                                      // Image.asset(
                                      //   result["image"],
                                      //   width: 120,
                                      //   height: 100,
                                      //   fit: BoxFit.cover,
                                      // ),
                                    ),
                                    title: Text(
                                      result["name"],
                                      style: const TextStyle(
                                        fontSize: 17.5,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    subtitle: Text(
                                      result["category"],
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ),
                              )
                            : Container(
                                margin: EdgeInsets.only(
                                  bottom: 30,
                                  left: 8,
                                ),
                                decoration: const BoxDecoration(
                                  color: Color(0xFFffffff),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    bottomLeft: Radius.circular(30),
                                  ),
                                ),
                                height:
                                    containerHeight, // Adjust based on screen size
                                width:
                                    containerWidth, // Adjust based on screen size
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: ListTile(
                                    leading: ClipRRect(
                                      borderRadius: BorderRadius.circular(30),
                                      child: Image.file(
                                        File(
                                          result["image"],
                                        ),
                                        width: 120,
                                        height: 100,
                                        fit: BoxFit.cover,
                                      ),
                                      // Image.asset(
                                      //   result["image"],
                                      //   width: 120,
                                      //   height: 100,
                                      //   fit: BoxFit.cover,
                                      // ),
                                    ),
                                    title: Text(
                                      result["name"],
                                      style: const TextStyle(
                                        fontSize: 17.5,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    subtitle: Text(
                                      result["category"],
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ),
                              ),
                        GestureDetector(
                          onTap: () async {
                            // Get the category name from the current slide
                            final categoryName = category["name"];
                            await fetchDataFromAPI();
                            print("registerID for checkkk");
                            print(result["registerID"]);

                            final isFavorite = await checkFavorite(
                                result["iditem"], registerID);
                            isFavoritee = isFavorite;
                            print('Is Favorite: $isFavorite');

                            final isReserved = await checkReserved(
                                result["iditem"], registerID);
                            isReservedd = isReserved;
                            print('Is Reserved: $isReserved');

                            // Check if a detail page is defined for the category
                            if (categoryDetailPages.containsKey(categoryName)) {
                              final detailPageBuilder =
                                  categoryDetailPages[categoryName];
                              if (detailPageBuilder != null) {
                                // Build and navigate to the appropriate detail page
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => detailPageBuilder(
                                      result["iditem"],
                                      Furnitures,
                                      isFavoritee,
                                      isReservedd),
                                ));
                              }
                            }
                          },
                          child: Intl.getCurrentLocale() == 'ar'
                              ? Container(
                                  margin: const EdgeInsets.only(
                                      bottom: 30, left: 8),
                                  decoration: BoxDecoration(
                                    color: Color(0xFF117a5d),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30),
                                      bottomLeft: Radius.circular(30),
                                    ),
                                  ),
                                  height:
                                      containerHeight, // Adjust based on screen size
                                  width: MediaQuery.of(context).size.width *
                                      0.2, // Adjust based on screen size
                                  child: Icon(
                                    Icons.keyboard_double_arrow_left,

                                    color: Colors.white,
                                    size:
                                        70, // Adjust the size to your preference
                                  ),
                                )
                              : Container(
                                  margin: const EdgeInsets.only(
                                      bottom: 30, right: 8),
                                  decoration: BoxDecoration(
                                    color: Color(0xFF117a5d),
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(30),
                                      bottomRight: Radius.circular(30),
                                    ),
                                  ),
                                  height:
                                      containerHeight, // Adjust based on screen size
                                  width: MediaQuery.of(context).size.width *
                                      0.2, // Adjust based on screen size
                                  child: Icon(
                                    Icons.keyboard_double_arrow_right,
                                    color: Colors.white,
                                    size:
                                        70, // Adjust the size to your preference
                                  ),
                                ),
                        ),
                      ],
                    );
                  },
                ),
        )
      ],
    );
  }
}
