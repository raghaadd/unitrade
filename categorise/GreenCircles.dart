import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_project_1st/accountpaage/otherUserAccount.dart';
import 'package:flutter_project_1st/generated/l10n.dart';
import 'package:flutter_project_1st/settingpage/theme/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class GreenCricles extends StatelessWidget {
  const GreenCricles({
    super.key,
    required this.item,
  });

  final Map item;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Expanded(
      flex: 4,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            color: const Color(0xFF117a5d),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item["title"],
                  style: TextStyle(
                    color: themeProvider.isDarkMode
                        ? Color(0xFF000000)
                        : Color(0xFFffffff),
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Intl.getCurrentLocale() == 'ar'
              ? Positioned(
                  right: 15,
                  top: 70,
                  child: Container(
                    width: 45,
                    height: 70,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF33c787),
                    ),
                    child: Icon(
                      Icons.person_sharp,
                      color: themeProvider.isDarkMode
                          ? Color(0xFF000000)
                          : Color(0xFFffffff),
                      size: 30,
                    ),
                  ),
                )
              : Positioned(
                  left: 15,
                  top: 70,
                  child: Container(
                    width: 45,
                    height: 70,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF33c787),
                    ),
                    child: Icon(
                      Icons.person_sharp,
                      color: themeProvider.isDarkMode
                          ? Color(0xFF000000)
                          : Color(0xFFffffff),
                      size: 30,
                    ),
                  ),
                ),
          Intl.getCurrentLocale() == 'ar'
              ? Positioned(
                  right: 15,
                  top: 135,
                  child: Container(
                    width: 45,
                    height: 70,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF33c787),
                    ),
                    child: Icon(
                      Icons.book,
                      color: themeProvider.isDarkMode
                          ? Color(0xFF000000)
                          : Color(0xFFffffff),
                      size: 30,
                    ),
                  ),
                )
              : Positioned(
                  left: 15,
                  top: 135,
                  child: Container(
                    width: 45,
                    height: 70,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF33c787),
                    ),
                    child: Icon(
                      Icons.book,
                      color: themeProvider.isDarkMode
                          ? Color(0xFF000000)
                          : Color(0xFFffffff),
                      size: 30,
                    ),
                  ),
                ),
          Intl.getCurrentLocale() == 'ar'
              ? Positioned(
                  right: 15,
                  top: 200,
                  child: Container(
                    width: 45,
                    height: 70,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF33c787),
                    ),
                    child: Icon(
                      Icons.date_range_rounded,
                      color: themeProvider.isDarkMode
                          ? Color(0xFF000000)
                          : Color(0xFFffffff),
                      size: 30,
                    ),
                  ),
                )
              : Positioned(
                  left: 15,
                  top: 200,
                  child: Container(
                    width: 45,
                    height: 70,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF33c787),
                    ),
                    child: Icon(
                      Icons.date_range_rounded,
                      color: themeProvider.isDarkMode
                          ? Color(0xFF000000)
                          : Color(0xFFffffff),
                      size: 30,
                    ),
                  ),
                ),
          Intl.getCurrentLocale() == 'ar'
              ? Positioned(
                  right: 15,
                  top: 265,
                  child: Container(
                    width: 45,
                    height: 70,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF33c787),
                    ),
                    child: Icon(
                      Icons.phone,
                      color: themeProvider.isDarkMode
                          ? Color(0xFF000000)
                          : Color(0xFFffffff),
                      size: 30,
                    ),
                  ),
                )
              : Positioned(
                  left: 15,
                  top: 265,
                  child: Container(
                    width: 45,
                    height: 70,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF33c787),
                    ),
                    child: Icon(
                      Icons.phone,
                      color: themeProvider.isDarkMode
                          ? Color(0xFF000000)
                          : Color(0xFFffffff),
                      size: 30,
                    ),
                  ),
                ),
          Intl.getCurrentLocale() == 'ar'
              ? Positioned(
                  right: 75,
                  top: 85,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          S.of(context).Name,
                          style: TextStyle(
                            color: themeProvider.isDarkMode
                                ? Color(0xFF000000)
                                : Color(0xFFffffff),
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => otherUserAccountPage(
                                          userRegisterID:
                                              item["registerID"].toString(),
                                          flagReserved: false,
                                          itemTitle: '',
                                          itemId: '',
                                          goNotification: false,
                                          flagReservedResult: false,
                                          desicion: false,
                                          price: " ",
                                        )));
                          },
                          child: Text(
                            item["Fname"] + " " + item["Lname"],
                            style: TextStyle(
                              color: themeProvider.isDarkMode
                                  ? Color(0xFF000000)
                                  : Color(0xFFffffff),
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ]),
                )
              : Positioned(
                  left: 75,
                  top: 85,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          S.of(context).Name,
                          style: TextStyle(
                            color: themeProvider.isDarkMode
                                ? Color(0xFF000000)
                                : Color(0xFFffffff),
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => otherUserAccountPage(
                                          userRegisterID:
                                              item["registerID"].toString(),
                                          flagReserved: false,
                                          itemTitle: '',
                                          itemId: '',
                                          goNotification: false,
                                          flagReservedResult: false,
                                          desicion: false,
                                          price: " ",
                                        )));
                          },
                          child: Text(
                            item["Fname"] + " " + item["Lname"],
                            style: TextStyle(
                              color: themeProvider.isDarkMode
                                  ? Color(0xFF000000)
                                  : Color(0xFFffffff),
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ]),
                ),
          Intl.getCurrentLocale() == 'ar'
              ? Positioned(
                  right: 75,
                  top: 145,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          S.of(context).Category,
                          style: TextStyle(
                            color: themeProvider.isDarkMode
                                ? Color(0xFF000000)
                                : Color(0xFFffffff),
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          item["category"],
                          style: TextStyle(
                            color: themeProvider.isDarkMode
                                ? Color(0xFF000000)
                                : Color(0xFFffffff),
                            fontSize: 12,
                          ),
                        ),
                      ]),
                )
              : Positioned(
                  left: 75,
                  top: 145,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          S.of(context).Category,
                          style: TextStyle(
                            color: themeProvider.isDarkMode
                                ? Color(0xFF000000)
                                : Color(0xFFffffff),
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          item["category"],
                          style: TextStyle(
                            color: themeProvider.isDarkMode
                                ? Color(0xFF000000)
                                : Color(0xFFffffff),
                            fontSize: 12,
                          ),
                        ),
                      ]),
                ),
          Intl.getCurrentLocale() == 'ar'
              ? Positioned(
                  right: 75,
                  top: 275,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          S.of(context).Phone,
                          style: TextStyle(
                            color: themeProvider.isDarkMode
                                ? Color(0xFF000000)
                                : Color(0xFFffffff),
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          item["phoneNumber"],
                          style: TextStyle(
                            color: themeProvider.isDarkMode
                                ? Color(0xFF000000)
                                : Color(0xFFffffff),
                            fontSize: 12,
                          ),
                        ),
                      ]),
                )
              : Positioned(
                  left: 75,
                  top: 275,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          S.of(context).Phone,
                          style: TextStyle(
                            color: themeProvider.isDarkMode
                                ? Color(0xFF000000)
                                : Color(0xFFffffff),
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          item["phoneNumber"],
                          style: TextStyle(
                            color: themeProvider.isDarkMode
                                ? Color(0xFF000000)
                                : Color(0xFFffffff),
                            fontSize: 12,
                          ),
                        ),
                      ]),
                ),
          Intl.getCurrentLocale() == 'ar'
              ? Positioned(
                  right: 75,
                  top: 210,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          S.of(context).Date,
                          style: TextStyle(
                            color: themeProvider.isDarkMode
                                ? Color(0xFF000000)
                                : Color(0xFFffffff),
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          item["Date"],
                          style: TextStyle(
                            color: themeProvider.isDarkMode
                                ? Color(0xFF000000)
                                : Color(0xFFffffff),
                            fontSize: 12,
                          ),
                        ),
                      ]),
                )
              : Positioned(
                  left: 75,
                  top: 210,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          S.of(context).Date,
                          style: TextStyle(
                            color: themeProvider.isDarkMode
                                ? Color(0xFF000000)
                                : Color(0xFFffffff),
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          item["Date"],
                          style: TextStyle(
                            color: themeProvider.isDarkMode
                                ? Color(0xFF000000)
                                : Color(0xFFffffff),
                            fontSize: 12,
                          ),
                        ),
                      ]),
                ),
          Intl.getCurrentLocale() == 'ar'
              ? Positioned(
                  left: 3,
                  top: 80,
                  child: Container(
                    width: 230,
                    height: 230,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.white,
                      image: DecorationImage(
                        image: FileImage(
                          File(item["image"]),
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                )
              : Positioned(
                  right: 3,
                  top: 80,
                  child: Container(
                    width: 230,
                    height: 230,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.white,
                      image: DecorationImage(
                        image: FileImage(
                          File(item["image"]),
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
