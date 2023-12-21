import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_project_1st/Notificationpage/CustomAlertConten.dart';
import 'package:flutter_project_1st/generated/l10n.dart';
import 'package:flutter_project_1st/homepage/hidden_drawer.dart';
import 'package:flutter_project_1st/ipaddress.dart';
import 'package:flutter_project_1st/registerID.dart';
import 'package:flutter_project_1st/settingpage/theme/theme_provider.dart';
import 'package:flutter_project_1st/settingpage/widgets/setting_item.dart';
import 'package:flutter_project_1st/settingpage/widgets/setting_switch.dart';
import 'package:ionicons/ionicons.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class settingPage extends StatefulWidget {
  const settingPage({super.key});

  @override
  State<settingPage> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<settingPage> {
  bool isDarkMode = false;
  bool isHovered = false;
  String Fname = '';
  String Lname = '';
  String Major = '';
  String About = '';
  String Profileimage = '';
  String registerid = '';
  final double profileHeight = 144;

  @override
  void initState() {
    super.initState();
    initializeData();
  }

  Future<void> initializeData() async {
    try {
      final userData = Provider.of<UserData>(context, listen: false);
      final registerID = userData.registerID;
      registerid = registerID;

      // ignore: unnecessary_null_comparison
      if (registerID != null) {
        print("inside initializeData");
        print(registerID);
        await fetchProfileInfo(registerID);
      } else {
        // Handle the case where registerID is null
        print('RegisterID is null.');
      }
    } catch (error) {
      // Handle errors
      print('Error initializing data: $error');
    }
  }

  Future<void> fetchProfileInfo(String registerID) async {
    print("inside fetchProfileInfo");
    final ipAddress = await getLocalIPv4Address();
    final url = Uri.parse('http://$ipAddress:3000/profileInfo/$registerID');

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        if (jsonResponse is List && jsonResponse.isNotEmpty) {
          final firstItem = jsonResponse.first;
          print('First Item: $firstItem');

          final fname = firstItem['Fname'];
          final lname = firstItem['Lname'];
          final major = firstItem['major'];
          final about = firstItem['about'];
          final profileimage = firstItem['profileimage'];

          setState(() {
            Fname = fname;
            Lname = lname;
            Major = major != null ? major.toString() : 'Student Major';
            About = about != null
                ? about.toString()
                : 'Write any additinaol information';
            Profileimage = profileimage ?? '';
            ;
          });
        } else {
          // Handle unexpected response format
          print('Invalid response format');
        }
      } else {
        // Handle errors or server response based on status code
        print('HTTP error: ${response.statusCode}');
      }
    } catch (error) {
      // Handle network or other errors
      print('Error: $error');
    }
  }

  Future<void> _showLanguageDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Text(
                  'Select Language',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 16),
              CustomAlertContent(
                  alertText: "Please Select the language you want"),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context); // Close Dialog
                        Provider.of<ThemeProvider>(context, listen: false)
                            .setAppLocale(const Locale('en'));
                      },
                      child: Text(
                        'English',
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context); // Close Dialog
                        Provider.of<ThemeProvider>(context, listen: false)
                            .setAppLocale(const Locale('ar'));
                      },
                      child: Text(
                        'العربية',
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: themeProvider.isDarkMode ? Colors.black87 : Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: themeProvider.isDarkMode
                      ? Colors.black45
                      : Colors.grey[300], // Adjust border radius as needed
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.of(context).Account,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: themeProvider.isDarkMode
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: profileHeight / 4.5,
                            backgroundColor: Colors.grey.shade300,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                if (Profileimage.isEmpty)
                                  Icon(
                                    Icons.person,
                                    size: 50,
                                    color: Colors.white,
                                  ),
                                if (Profileimage.isNotEmpty)
                                  ClipOval(
                                    child: Image.file(
                                      File(Profileimage),
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: double.infinity,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                Fname + " " + Lname,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: themeProvider.isDarkMode
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                Major,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              )
                            ],
                          ),
                          Spacer(),
                          MouseRegion(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const HiddenDrawer(page: 3),
                                  ),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: themeProvider.isDarkMode
                                      ? Colors.black12
                                      : Colors.grey[300],
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                padding: EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 16),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Intl.getCurrentLocale() == 'ar'
                                          ? Ionicons.chevron_back
                                          : Ionicons.chevron_forward,
                                      color: themeProvider.isDarkMode
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: themeProvider.isDarkMode
                      ? Colors.black45
                      : Colors.grey[300],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //SizedBox(height: 40),
                    Text(
                      S.of(context).Settings,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: themeProvider.isDarkMode
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                    SizedBox(height: 20),

                    SettingItem(
                      title: S.of(context).Language,
                      icon: Ionicons.earth,
                      bgColor: Colors.transparent,
                      iconColor: Colors.grey,
                      value: S.of(context).Lang_type,
                      onTap: () {
                        _showLanguageDialog(context);
                      },
                      isDarkmode: themeProvider.isDarkMode,
                    ),
                    SizedBox(height: 20),
                    SettingItem(
                        title: S.of(context).Chnage_pass,
                        icon: Ionicons.key,
                        bgColor: Colors.transparent,
                        iconColor: Colors.grey,
                        onTap: () {},
                        isDarkmode: themeProvider.isDarkMode),
                    const SizedBox(height: 20),
                    // GestureDetector(
                    //   onTap: () {
                    //     print("notification");
                    //     Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //             builder: (context) => NotificationMain(
                    //                   reservedArray: reservedArray,
                    //                   resultReservedArray: resultReservedArray,
                    //                   title: "Notification",
                    //                 )));
                    //   },
                    //   child: SettingItem(
                    //       title: "Notifications",
                    //       icon: Ionicons.notifications,
                    //       bgColor: Colors.transparent,
                    //       iconColor: Colors.grey,
                    //       onTap: () {},
                    //       isDarkmode: themeProvider.isDarkMode),
                    // ),
                    SettingSwitch(
                      title: S.of(context).Notifications,
                      icon: Ionicons.notifications,
                      bgColor: Colors.transparent,
                      iconColor: Colors.grey,
                      value: false,
                      onTap: (value) {},
                      isDarkmode: themeProvider.isDarkMode,
                    ),
                    const SizedBox(height: 20),
                    SettingSwitch(
                      title: S.of(context).Dark_mode,
                      icon: Ionicons.earth,
                      bgColor: Colors.transparent,
                      iconColor: Colors.grey,
                      value: themeProvider.isDarkMode,
                      onTap: (value) {
                        Provider.of<ThemeProvider>(context, listen: false)
                            .setDarkMode(value);
                        // Call a function or perform logic when dark mode is toggled
                        setState(() {
                          isDarkMode = !isDarkMode;
                          value = isDarkMode;
                        });
                        print("Dark Mode is ${value ? 'On' : 'Off'}");
                      },
                      isDarkmode: themeProvider.isDarkMode,
                    ),

                    const SizedBox(height: 20),
                    SettingItem(
                        title: S.of(context).Send_feedback,
                        icon: Ionicons.chatbox,
                        bgColor: Colors.transparent,
                        iconColor: Colors.grey,
                        onTap: () {},
                        isDarkmode: themeProvider.isDarkMode),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
