import 'package:flutter/material.dart';
import 'package:flutter_project_1st/adminPage/adminMain.dart';
import 'package:flutter_project_1st/adminPage/meals/mealsMain.dart';
import 'package:flutter_project_1st/adminPage/offers/offerMain.dart';
import 'package:flutter_project_1st/adminPage/report/report.dart';
import 'package:flutter_project_1st/adminPage/users/Student_table.dart';
import 'package:flutter_project_1st/chatpage/chatpage.dart';
import 'package:flutter_project_1st/getStarted.dart';
import 'package:flutter_project_1st/settingpage/theme/theme_provider.dart';
import 'package:flutter_project_1st/websiteHomePage.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:intl/intl.dart';

import 'chatPageAdmin/chatAdmin.dart';
import 'feedback/feedbackMain.dart';
import 'items/itemsMain.dart';
import 'search/searchmain.dart';

class adminPage extends StatefulWidget {
  const adminPage({
    Key? key,
    required this.page,
  }) : super(key: key);
  final int page;

  @override
  State<adminPage> createState() => _adminPageState();
}

class _adminPageState extends State<adminPage> {
  List<ScreenHiddenDrawer> _pages = [];
  bool notification_flag = false;
  String itemOwner = '';
  List<Map<String, dynamic>> reservedArray = [];
  List<Map<String, dynamic>> resultReservedArray = [];
  List<Map<String, dynamic>> paymentArray = [];
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
        adminMain(),
      ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: Intl.getCurrentLocale() == 'ar' ? "البحث " : "Search",
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
        searchMain(),
      ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: Intl.getCurrentLocale() == 'ar' ? "المستخدمين " : "Users",
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
        TableWidget(),
      ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: Intl.getCurrentLocale() == 'ar' ? "العروضات " : "Offers",
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
        offerMain(),
      ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: Intl.getCurrentLocale() == 'ar' ? "وجبات " : "Meals",
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
        mealsMain(),
      ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: Intl.getCurrentLocale() == 'ar' ? "العناصر " : "Items",
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
        itemMain(),
      ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: Intl.getCurrentLocale() == 'ar' ? "الصفحة الرئيسية" : "Podcast",
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
        adminMain(),
      ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: Intl.getCurrentLocale() == 'ar' ? "التغذية الراجعة " : "Rate",
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
        feedbackMain(),
      ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: Intl.getCurrentLocale() == 'ar' ? "إبلاغ " : "Feedback",
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
        ReportWidget(),
      ),
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
    //initializeData();
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
      slidePercent: kIsWeb ? 20.0 : 60.0,
      //    verticalScalePercent: 80.0,
      //    contentCornerRadius: 10.0
      //    backgroundContent: DecorationImage((image: ExactAssetImage('assets/bg_news.jpg'),fit: BoxFit.cover),
      //    whithAutoTittleName: true,
      //styleAutoTittleName: TextStyle(color: Colors.red),
      // actionsAppBar: <Widget>[
      //   IconButton(
      //     onPressed: () {
      //       // Handle notification icon press
      //       print("notification page");
      //       initializeData();
      //       Navigator.push(
      //         context,
      //         MaterialPageRoute(
      //             builder: (context) => NotificationMain(
      //                   reservedArray: reservedArray,
      //                   resultReservedArray: resultReservedArray,
      //                   paymentArray: paymentArray,
      //                   title: S.of(context).Notifications,
      //                   fromUserprofiel: false,
      //                 )),
      //       );
      //     },
      //     icon: Icon(
      //         notification_flag
      //             ? Icons.notifications_active
      //             : Icons.notifications_active_outlined,
      //         size: 25,
      //         color:
      //             themeProvider.isDarkMode ? Colors.black : Color(0xFFffffff)),
      //   ),
      //],

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

      actionsAppBar: <Widget>[
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => chatAdmin()),
            );
          },
          icon: Icon(Icons.chat_bubble, size: 25, color: Color(0xFFffffff)),
        ),
      ],
      // enableShadowItensMenu: true,
      // backgroundMenu: DecorationImage(
      //     image: ExactAssetImage('assets/page4_remove.png'), fit: BoxFit.cover),
    );
  }

  void logout() {
    // Implement your logout logic here.
    // For example, clear user data and navigate to the login screen.
    // Navigate to the login screen
    if (kIsWeb) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => websiteHomePage()));
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => getStarted()));
    }
  }
}
