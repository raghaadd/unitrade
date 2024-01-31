import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_project_1st/categorise/furniturepage/furniture_details.dart';
import 'package:flutter_project_1st/generated/l10n.dart';
import 'package:flutter_project_1st/ipaddress.dart';
import 'package:http/http.dart' as http;

class searchItems extends StatefulWidget {
  const searchItems({super.key});

  @override
  State<searchItems> createState() => _searchItemsState();
}

class _searchItemsState extends State<searchItems> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  List<Map<String, dynamic>> _founditems = [];
  bool isTextFieldFocused = true; // Track the focus state

  List<Map<String, dynamic>> allitems = [];

  void initState() {
    // TODO: implement initState
    super.initState();
    initializeData();
  }

  Future<void> initializeData() async {
    try {
      await searchItemsResults();
      print('mealArray: $allitems');

      if (allitems.isNotEmpty) {
        setState(() {
          allitems = allitems;
        });
      }
    } catch (error) {
      // Provide more meaningful error handling or logging
      print('Error initializing data: $error');
    }
  }

  Future<void> searchItemsResults() async {
    // Replace with your API endpoint
    final ipAddress = await getLocalIPv4Address();
    print("*********************************************");
    print(ipAddress);
    final response =
        await http.get(Uri.parse('http://$ipAddress:3000/searchItems'));
    if (response.statusCode == 200) {
      print(response.statusCode);
      final List<dynamic> data = jsonDecode(response.body);
      setState(() {
        allitems = data.map((item) {
          return {
            "id": item["iditem"],
            "title": item["title"],
            "price": item["price"],
            "image": item["image"],
            "category": item["CategoryName"],
            "Date": item["date"],
            "phoneNumber": item["phoneNumber"],
            "status": item["status"],
            "description": item["description"],
            "Fname": item["Fname"],
            "Lname": item["Lname"],
          };
        }).toList();
        print("Items details: $allitems");
      });
    } else {
      // Handle API error
      print('Failed to load furniture details');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      results = allitems;
    } else {
      results = allitems
          .where((item) => item["title"]
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      _founditems = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFffffff),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(children: [
          const SizedBox(
            height: 25,
          ),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _controller,
                  focusNode: _focusNode,
                  onChanged: (value) => _runFilter(value),
                  decoration: InputDecoration(
                    hintText: S.of(context).Search,
                    prefixIcon: Icon(Icons.search),
                    contentPadding: EdgeInsets.all(10),
                    filled: true,
                    fillColor: Color(0xFFebedee).withOpacity(0.85),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    hintStyle: TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(255, 170, 170, 170),
                    ),
                  ),
                  style: TextStyle(fontSize: 20, color: Color(0xFF000000)),
                  onTap: () {
                    setState(() {
                      isTextFieldFocused = true;
                    });
                  },
                  onFieldSubmitted: (_) {
                    setState(() {
                      isTextFieldFocused = false;
                    });
                  },
                ),
              ),
              isTextFieldFocused
                  ? TextButton(
                      onPressed: () {
                        setState(() {
                          _controller.clear();
                          _runFilter('');
                          FocusScope.of(context).unfocus();
                          isTextFieldFocused = false;
                          Navigator.pop(context);
                        });
                      },
                      child: Text(
                        S.of(context).Cancel,
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Color(0xFF000000).withOpacity(0.7),
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          // Conditionally display the item list based on focus state
          if (isTextFieldFocused)
            Expanded(
              child: ListView.builder(
                itemCount: _founditems.length,
                itemBuilder: (context, index) => Card(
                  key: ValueKey(_founditems[index]["id"]),
                  color: Color(0xFFffffff).withOpacity(0.8),
                  //Color(0xFFc0edda),
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: GestureDetector(
                    onTap: () async {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => FurnitureDetails(
                                itemId: _founditems[index]["id"],
                                Furnitures: _founditems,
                                isFavorite: false,
                                isReserved: false,
                                showNavBar: true,
                                gotoFav: false,
                              )));
                    },
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          _founditems[index]["image"],
                          width: 100,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(
                        _founditems[index]['title'],
                        style: TextStyle(
                            fontSize: 20,
                            color: Color(0xFF000000),
                            fontWeight: FontWeight.w800),
                      ),
                      subtitle: Text(
                        '${_founditems[index]["price"].toString()} ₪',
                        style: TextStyle(
                            color: Color(0xFF000000),
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ]),
      ),
    );
  }
}
