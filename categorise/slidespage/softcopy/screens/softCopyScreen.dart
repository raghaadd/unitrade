import 'dart:convert';

import 'package:flutter_project_1st/categorise/RecentlyAddedSoftCopy.dart';
import 'package:flutter_project_1st/categorise/appbar_page.dart';
import 'package:flutter_project_1st/ipaddress.dart';
import 'package:flutter_project_1st/settingpage/theme/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

class softcopy extends StatefulWidget {
  final int index;
  final int registerid;
  final int faculty;
  final int major;
  const softcopy(
      {super.key,
      required this.index,
      required this.registerid,
      required this.faculty,
      required this.major});

  @override
  State<softcopy> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<softcopy> {
  List<Map> freeslides = [];
  List<Map> paidslides = [];
  late final PageController pageController;
  @override
  void initState() {
    pageController = PageController(initialPage: 0, viewportFraction: 0.85);
    freeSoftSlides(widget.registerid, widget.faculty,
        widget.major); // Call the method to fetch data
    paidSoftSlides(widget.registerid, widget.faculty, widget.major);
    super.initState();
  }

  Future<void> freeSoftSlides(int registerId, int faculty, int major) async {
    final ipAddress = await getLocalIPv4Address();
    final response = await http.get(Uri.parse(
        'http://$ipAddress:3000/softslidespage/$registerId/$faculty/$major'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      setState(() {
        freeslides = data.map((item) {
          return {
            "iditem": item["iditem"],
            "image": item["image"],
            "title": item["title"],
            "category": item["CategoryName"],
            "registerID": item["registerID"],
            "Fname":item["Fname"],
            "Lname":item["Lname"],
          };
        }).toList();
      });
    } else {
      throw Exception('Failed to load slides items');
    }
  }

  Future<void> paidSoftSlides(int registerId, int faculty, int major) async {
    final ipAddress = await getLocalIPv4Address();
    final response = await http.get(Uri.parse(
        'http://$ipAddress:3000/paidsoftslidespage/$registerId/$faculty/$major'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      setState(() {
        paidslides = data.map((item) {
          return {
            "iditem": item["iditem"],
            "image": item["image"],
            "title": item["title"],
            "category": item["CategoryName"],
            "registerID": item["registerID"],
            "Fname":item["Fname"],
            "Lname":item["Lname"],
            "price":item["price"],
          };
        }).toList();
      });
    } else {
      throw Exception('Failed to load slides items');
    }
  }

  @override
  Widget build(BuildContext context) {
    //var size = MediaQuery.of(context).size;
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: appBarPage(slidepage: true),
      ),
      backgroundColor: themeProvider.isDarkMode
          ? Color.fromARGB(255, 25, 25, 25)
          : Color(0xFFffffff).withOpacity(0.93),
      body: RecentlyaddedSoftCopy(free: freeslides, hard:paidslides, indexx: 0),
    );
  }
}
