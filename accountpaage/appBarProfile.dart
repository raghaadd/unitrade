import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_project_1st/Notificationpage/notificationMain.dart';
import 'package:flutter_project_1st/generated/l10n.dart';
import 'package:flutter_project_1st/ipaddress.dart';
import 'package:flutter_project_1st/registerID.dart';
import 'package:flutter_project_1st/settingpage/theme/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class appBarProfile extends StatefulWidget {
  const appBarProfile({super.key, required this.goNotification});
  final bool goNotification;

  @override
  State<appBarProfile> createState() => _appBarProfileState();
}

class _appBarProfileState extends State<appBarProfile> {
  List<Map<String, dynamic>> reservedArray = [];
  List<Map<String, dynamic>> resultReservedArray = [];
  bool notification_flag = false;
  @override
  void initState() {
    super.initState();
    initializeData();
  }

  Future<void> initializeData() async {
    try {
      final userData = Provider.of<UserData>(context, listen: false);
      final registerID = userData.registerID;
      reservedArray = await getReserved(registerID.toString());
      resultReservedArray = await getReservedResult(registerID.toString());
      print('reservedArray: $reservedArray');
      print('resultReservedArray: $resultReservedArray');

      if (reservedArray.isNotEmpty || resultReservedArray.isNotEmpty) {
        setState(() {
          reservedArray = reservedArray;
          resultReservedArray = resultReservedArray;
          notification_flag = true;
        });
      }
    } catch (error) {
      // Provide more meaningful error handling or logging
      print('Error initializing data: $error');
    }
  }

  Future<List<Map<String, dynamic>>> getReserved(String itemOwner) async {
    final ipAddress = await getLocalIPv4Address();
    final String apiUrl = "http://$ipAddress:3000/getReserved/$itemOwner";

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        // Parse the response body
        List<dynamic> data = json.decode(response.body);

        // Convert the list of dynamic to List<Map<String, dynamic>>
        List<Map<String, dynamic>> reservedarray =
            List<Map<String, dynamic>>.from(data);
        return reservedarray;
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

  Future<List<Map<String, dynamic>>> getReservedResult(
      String itemRequester) async {
    final ipAddress = await getLocalIPv4Address();
    final String apiUrl =
        "http://$ipAddress:3000/getReservedResult/$itemRequester";

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        // Parse the response body
        List<dynamic> data = json.decode(response.body);

        // Convert the list of dynamic to List<Map<String, dynamic>>
        List<Map<String, dynamic>> resultreservedarray =
            List<Map<String, dynamic>>.from(data);
        return resultreservedarray;
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
    return AppBar(
      backgroundColor: Color(0xFF117a5d),
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios_new_outlined,
          color: themeProvider.isDarkMode
              ? Color(0xFF000000)
              : Colors.grey.shade200,
          size: 30,
        ),
        onPressed: () {
          if (widget.goNotification) {
            print("inside notification in appbar");
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => NotificationMain(
                        reservedArray: reservedArray,
                        resultReservedArray: resultReservedArray,
                        title: S.of(context).Notifications,
                        fromUserprofiel: true,
                      )),
            );
          } else {
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
