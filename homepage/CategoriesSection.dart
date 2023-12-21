import 'package:flutter/material.dart';
import 'package:flutter_project_1st/Notificationpage/CustomAlertConten.dart';
import 'package:flutter_project_1st/additems/additem3.dart';
import 'package:flutter_project_1st/categorise/electricalspage/Electricalspage.dart';
import 'package:flutter_project_1st/categorise/electronicpage/Electronicpage.dart';
import 'package:flutter_project_1st/categorise/furniturepage/Furniturepage.dart';
import 'package:flutter_project_1st/categorise/slidespage/Slidespage.dart';
import 'package:flutter_project_1st/generated/l10n.dart';
import 'package:flutter_project_1st/registerID.dart';
import 'package:flutter_project_1st/settingpage/theme/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import 'faculty_Major.dart';

class CategoriesSection extends StatefulWidget {
  const CategoriesSection({super.key});

  @override
  State<CategoriesSection> createState() => _CategoriesSectionState();
}

class _CategoriesSectionState extends State<CategoriesSection> {
  List<Map> categories = [
    {
      "name": Intl.getCurrentLocale() == 'ar' ? "سلايدات" : "Slides",
      "icon": Icons.book,
    },
    {
      "name": Intl.getCurrentLocale() == 'ar' ? "إلكترونيات" : "Electronic",
      "icon": Icons.electric_bolt,
    },
    {
      "name": Intl.getCurrentLocale() == 'ar' ? "كهربائيات" : "Electricals",
      "icon": Icons.electrical_services_sharp,
    },
    {
      "name": Intl.getCurrentLocale() == 'ar' ? "مفروشات" : "Furniture",
      "icon": Icons.chair,
    },
  ];
  int _selectedFacultyRadio = 0;
  int _selectedMajorityRadio = 0;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    double containerHeight = MediaQuery.of(context).size.height * 0.26;
    double containerWidth = MediaQuery.of(context).size.width * 0.73;
    final userData = Provider.of<UserData>(context);
    final registerID = int.parse(userData.registerID);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                S.of(context).Categories,
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
        SizedBox(height: 20),
        Container(
          height: 150,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  if (categories[index]['name'] == 'Slides' ||
                      categories[index]['name'] == 'سلايدات') {
                    // Show a dialog before navigating to SlidesPage

                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Center(
                                child: Text(
                                  S.of(context).Copy_type,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              SizedBox(height: 16),
                              CustomAlertContent(
                                alertText: S.of(context).select_the_copy_type,
                              ),
                              SizedBox(height: 16),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Center(
                                    child: TextButton(
                                      onPressed: () {
                                        Navigator.pop(context); // Close Dialog
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    faculty_Major(
                                                      containerHeight:
                                                          containerHeight,
                                                      containerWidth:
                                                          containerWidth,
                                                      onFacultySelected:
                                                          (selectedRadio) {
                                                        setState(() {
                                                          _selectedFacultyRadio =
                                                              selectedRadio;
                                                        });
                                                      },
                                                      onMajoritySelected:
                                                          (selectedRadio) {
                                                        setState(() {
                                                          _selectedMajorityRadio =
                                                              selectedRadio;
                                                        });
                                                      },
                                                      flagHard: false,
                                                      registerid: registerID,
                                                    )));
                                      },
                                      child: Text(
                                        S.of(context).Software,
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
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    faculty_Major(
                                                      containerHeight:
                                                          containerHeight,
                                                      containerWidth:
                                                          containerWidth,
                                                      onFacultySelected:
                                                          (selectedRadio) {
                                                        setState(() {
                                                          _selectedFacultyRadio =
                                                              selectedRadio;
                                                        });
                                                      },
                                                      onMajoritySelected:
                                                          (selectedRadio) {
                                                        setState(() {
                                                          _selectedMajorityRadio =
                                                              selectedRadio;
                                                        });
                                                      },
                                                      flagHard: true,
                                                      registerid: registerID,
                                                    )));
                                      },
                                      child: Text(
                                        S.of(context).Hardware,
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
                  } else {
                    // Navigate to other pages without a pop-up
                    navigateToCategoryPage(context, index, registerID);
                  }
                },
                child: Container(
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(23.0),
                        margin: EdgeInsets.only(left: 18, right: 18),
                        decoration: BoxDecoration(
                          color: Color(0xFFffffff),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Color(0xFFd6d6d6).withOpacity(0.7),
                            width: 2,
                          ),
                        ),
                        child: Icon(
                          categories[index]['icon'],
                          size: 25,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        categories[index]['name'],
                        style: TextStyle(
                          color: themeProvider.isDarkMode
                              ? Color(0xFFffffff)
                              : Color(0xFF000000),
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  void navigateToCategoryPage(BuildContext context, int index, int registerID) {
    if (categories[index]['name'] == 'Electronic' ||
        categories[index]['name'] == 'إلكترونيات') {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) =>
              Electronicpage(index: 1, registerid: registerID),
        ),
      );
    } else if (categories[index]['name'] == 'Electricals' ||
        categories[index]['name'] == 'كهربائيات') {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) =>
              Electricalspage(index: 2, registerid: registerID),
        ),
      );
    } else if (categories[index]['name'] == 'Furniture' ||
        categories[index]['name'] == 'مفروشات') {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => Furniturepage(index: 3, registerid: registerID),
        ),
      );
    }
  }
}
