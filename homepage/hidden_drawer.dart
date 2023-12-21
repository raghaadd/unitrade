import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_project_1st/Notificationpage/notificationMain.dart';
import 'package:flutter_project_1st/generated/l10n.dart';
import 'package:flutter_project_1st/getStarted.dart';
import 'package:flutter_project_1st/helpPage/help.dart';
import 'package:flutter_project_1st/homepage/mainpage.dart';
import 'package:flutter_project_1st/ipaddress.dart';
import 'package:flutter_project_1st/log_sign_forgot/loginpage.dart';
import 'package:flutter_project_1st/registerID.dart';
import 'package:flutter_project_1st/settingpage/settingspage.dart';
import 'package:flutter_project_1st/settingpage/theme/theme_provider.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class HiddenDrawer extends StatefulWidget {
  const HiddenDrawer({Key? key, required this.page}) : super(key: key);
  final int page;

  @override
  State<HiddenDrawer> createState() => _HiddenDrawerState();
}

class _HiddenDrawerState extends State<HiddenDrawer> {
  List<ScreenHiddenDrawer> _pages = [];
  bool notification_flag = false;
  String itemOwner = '';
  List<Map<String, dynamic>> reservedArray = [];
  List<Map<String, dynamic>> resultReservedArray = [];
  late ThemeProvider themeProvider;
  @override
  void initState() {
    super.initState();
    themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    _pages = [
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name:
              Intl.getCurrentLocale() == 'ar' ? "الصفحة الرئيسية" : "HomePage",
          baseStyle: TextStyle(
              color:
                  themeProvider.isDarkMode ? Colors.black : Color(0xFFffffff),
              fontWeight: FontWeight.bold,
              fontSize: 18.0),
          selectedStyle: TextStyle(
              color: Color(0xFF117a5d),
              fontWeight: FontWeight.bold,
              fontSize: 18.0),
          colorLineSelected: Color(0xFF117a5d),
        ),
        mainpage(page: widget.page),
      ),
      ScreenHiddenDrawer(
          ItemHiddenMenu(
            name: Intl.getCurrentLocale() == 'ar' ? "مساعدة" : "Help",
            baseStyle: TextStyle(
                color:
                    themeProvider.isDarkMode ? Colors.black : Color(0xFFffffff),
                fontWeight: FontWeight.bold,
                fontSize: 18.0),
            selectedStyle: TextStyle(
              color: Color(0xFF117a5d),
            ),
            colorLineSelected: Color(0xFF117a5d),
          ),
          helpPage()),
      ScreenHiddenDrawer(
          ItemHiddenMenu(
            name: Intl.getCurrentLocale() == 'ar' ? "الإعدادات" : "Settings",
            baseStyle: TextStyle(
                color:
                    themeProvider.isDarkMode ? Colors.black : Color(0xFFffffff),
                fontWeight: FontWeight.bold,
                fontSize: 18.0),
            selectedStyle: TextStyle(
              color: Color(0xFF117a5d),
            ),
            colorLineSelected: Color(0xFF117a5d),
          ),
          settingPage()),
      ScreenHiddenDrawer(
          ItemHiddenMenu(
            name: Intl.getCurrentLocale() == 'ar' ? "تسجيل الخروج" : "Logout",
            baseStyle: TextStyle(
                color:
                    themeProvider.isDarkMode ? Colors.black : Color(0xFFffffff),
                fontWeight: FontWeight.bold,
                fontSize: 18.0),
            selectedStyle: TextStyle(
              color: Color(0xFF117a5d),
            ),
            colorLineSelected: Color(0xFF117a5d),
            onTap: () {
              logout();
            },
          ),
          Container()),
    ];
    initializeData();
  }

  Future<void> initializeData() async {
    try {
      final userData = Provider.of<UserData>(context, listen: false);
      final registerID = userData.registerID;
      itemOwner = registerID;
      reservedArray = await getReserved(itemOwner.toString());
      resultReservedArray = await getReservedResult(itemOwner.toString());
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
    return HiddenDrawerMenu(
      backgroundColorMenu: Color(0xFF117a5d).withOpacity(0.7),
      backgroundColorAppBar: Color(0xFF088054),
      // iconMenuAppBar: Icon(
      //   Icons.menu,
      //   color: Colors.white, // Set the menu icon color to white
      // ),
      screens: _pages,
      //    typeOpen: TypeOpen.FROM_RIGHT,
      //  disableAppBarDefault: false,

      //    enableScaleAnimin: true,
      //    enableCornerAnimin: true,
      slidePercent: 60.0,
      //    verticalScalePercent: 80.0,
      //    contentCornerRadius: 10.0
      //    backgroundContent: DecorationImage((image: ExactAssetImage('assets/bg_news.jpg'),fit: BoxFit.cover),
      //    whithAutoTittleName: true,
      //styleAutoTittleName: TextStyle(color: Colors.red),
      actionsAppBar: <Widget>[
        IconButton(
          onPressed: () {
            // Handle notification icon press
            print("notification page");
            initializeData();
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => NotificationMain(
                        reservedArray: reservedArray,
                        resultReservedArray: resultReservedArray,
                        title: S.of(context).Notifications,
                        fromUserprofiel: false,
                      )),
            );
          },
          icon: Icon(
              notification_flag
                  ? Icons.notifications_active
                  : Icons.notifications_active_outlined,
              size: 25,
              color:
                  themeProvider.isDarkMode ? Colors.black : Color(0xFFffffff)),
        ),
      ],

      //backgroundColorContent: Colors.blue,
      //    elevationAppBar: 4.0,
      tittleAppBar: Center(
        child: Text(
          "U N I T R A D E",
          style: TextStyle(
              color:
                  themeProvider.isDarkMode ? Colors.black : Color(0xFFffffff),
              fontWeight: FontWeight.bold,
              fontSize: 25.0),
        ),
      ),
      // enableShadowItensMenu: true,
      // backgroundMenu: DecorationImage(
      //     image: ExactAssetImage('assets/page4_remove.png'), fit: BoxFit.cover),
    );
  }

  void logout() {
    // Implement your logout logic here.
    // For example, clear user data and navigate to the login screen.
    // Navigate to the login screen
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => getStarted()));
  }
}
