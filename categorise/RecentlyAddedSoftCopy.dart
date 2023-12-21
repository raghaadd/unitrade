import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_project_1st/additems/clicktoAdditem.dart';
import 'package:flutter_project_1st/categorise/slidespage/softcopy/consttants.dart';
import 'package:flutter_project_1st/categorise/slidespage/softcopy/screens/details_screen.dart';
import 'package:flutter_project_1st/categorise/slidespage/softcopy/widgets/book_rating.dart';
import 'package:flutter_project_1st/categorise/slidespage/softcopy/widgets/reading_card_list.dart';
import 'package:flutter_project_1st/generated/l10n.dart';
import 'package:flutter_project_1st/ipaddress.dart';
import 'package:flutter_project_1st/registerID.dart';
import 'package:flutter_project_1st/settingpage/theme/theme_provider.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

import 'package:provider/provider.dart';

class RecentlyaddedSoftCopy extends StatefulWidget {
  const RecentlyaddedSoftCopy({
    Key? key,
    required this.free,
    required this.hard,
    required this.indexx,
  }) : super(key: key);

  final List<Map> free;
  final List<Map> hard;
  final int indexx;

  @override
  State<RecentlyaddedSoftCopy> createState() => _RecentlyaddedItemsState();
}

class _RecentlyaddedItemsState extends State<RecentlyaddedSoftCopy> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
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

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final userData = Provider.of<UserData>(context);
    final registerID = int.parse(userData.registerID);
    double containerWidth1 = MediaQuery.of(context).size.width * 0.9;
    double containerHeight1 = MediaQuery.of(context).size.height * 0.12; //0.16
    double containerHeight2 = MediaQuery.of(context).size.height * 0.15; //0.22
    return SingleChildScrollView(
      child: Column(
        children: [
          clicktoAddItem(
              containerHeight1: containerHeight1,
              containerWidth1: containerWidth1,
              containerHeight2: containerHeight2,
              slidepage: true),
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  S.of(context).free_books_slides,
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
          if (widget.free.isEmpty)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                S.of(context).no_slides_to_display,
                style: TextStyle(
                  fontSize: 18.0,
                  color: themeProvider.isDarkMode
                      ? Color(0xFFffffff)
                      : Color(0xFF000000).withOpacity(0.7),
                ),
              ),
            ),
          const SizedBox(height: 10),
          if (widget.free.isNotEmpty)
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: double.infinity,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: List.generate(
                                          widget.free.length,
                                          (index) => FutureBuilder<bool>(
                                            future: checkFavorite(
                                                widget.free[index]["iditem"],
                                                registerID),
                                            builder: (context, snapshot) {
                                              if (snapshot.connectionState ==
                                                  ConnectionState.waiting) {
                                                // Return a loading indicator or placeholder while waiting for the result.
                                                return CircularProgressIndicator();
                                              } else if (snapshot.hasError) {
                                                // Handle the error case.
                                                return Text(
                                                    'Error: ${snapshot.error}');
                                              } else {
                                                // Return the ReadingListCard with the result from the checkFavorite function.
                                                return ReadingListCard(
                                                  isFree: true,
                                                  pdfFilePath: widget
                                                      .free[index]['image'],
                                                  image: "assets/pdf.png",
                                                  title: widget.free[index]
                                                          ['title'] ??
                                                      "Unknown Title",
                                                  categ: widget.free[index]
                                                          ['Fname'] +
                                                      " " +
                                                      widget.free[index]
                                                          ['Lname'],
                                                  pressDetails: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) {
                                                          return DetailsScreen();
                                                        },
                                                      ),
                                                    );
                                                  },
                                                  pressRead: () {},
                                                  itemId: widget.free[index]
                                                      ['iditem'],
                                                  isFavorite:
                                                      snapshot.data ?? false,
                                                );
                                              }
                                            },
                                          ),
                                        )..add(SizedBox(width: 30)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  S.of(context).paid_books_slides,
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
          const SizedBox(height: 10),
          if (widget.hard.isEmpty)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                S.of(context).no_slides_to_display,
                style: TextStyle(
                  fontSize: 18.0,
                  color: themeProvider.isDarkMode
                      ? Color(0xFFffffff)
                      : Color(0xFF000000).withOpacity(0.7),
                ),
              ),
            ),
          if (widget.hard.isNotEmpty)
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(
                              widget.hard.length,
                              (index) => FutureBuilder<bool>(
                                future: checkFavorite(
                                    widget.hard[index]["iditem"], registerID),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    // Return a loading indicator or placeholder while waiting for the result.
                                    return CircularProgressIndicator();
                                  } else if (snapshot.hasError) {
                                    // Handle the error case.
                                    return Text('Error: ${snapshot.error}');
                                  } else {
                                    // Return the ReadingListCard with the result from the checkFavorite function.
                                    return ReadingListCard(
                                      isFree: false,
                                      pdfFilePath: widget.hard[index]['image'],
                                      image: "assets/pdf.png",
                                      title: widget.hard[index]['title'] ??
                                          "Unknown Title",
                                      categ: widget.hard[index]['Fname'] +
                                          " " +
                                          widget.hard[index]['Lname'] +
                                          "      " +
                                          widget.hard[index]['price']
                                              .toString() +
                                          "₪",
                                      pressDetails: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return DetailsScreen();
                                            },
                                          ),
                                        );
                                      },
                                      pressRead: () {},
                                      itemId: widget.hard[index]['iditem'],
                                      isFavorite: snapshot.data ?? false,
                                    );
                                  }
                                },
                              ),
                            )..add(SizedBox(width: 30)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Container beatOfTheDay(Size size, BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      width: double.infinity,
      height: 230,
      child: Stack(
        children: <Widget>[
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding:
                  EdgeInsets.only(left: 24, top: 24, right: size.width * .35),
              height: 220,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xFFEAEAEA).withOpacity(.45),
                borderRadius: BorderRadius.circular(29),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "FOURTH WING",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  SizedBox(height: 5),
                  Text(
                    "by Rebecca Yarros",
                    style: TextStyle(color: kLightBlackColor),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: <Widget>[
                      BookRating(score: 4.9),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          "Violet Sorrengail is urged by the commanding general, who also ...",
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 11,
                            color: kLightBlackColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            child: Image.asset("assets/fourthWing.png"),
            width: size.width * .37,
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: SizedBox(
              height: 40,
              width: size.width * .35,
              child: TwoSideRoundedButton(
                text: "Read",
                radious: 24,
                press: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TwoSideRoundedButton extends StatelessWidget {
  final String text;
  final double radious;
  final VoidCallback press;
  const TwoSideRoundedButton({
    Key? key,
    required this.text,
    this.radious = 29,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
            color: kBlackColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(radious),
              bottomRight: Radius.circular(radious),
            )),
        child: Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
