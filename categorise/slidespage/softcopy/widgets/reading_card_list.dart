import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_project_1st/generated/l10n.dart';
import 'package:flutter_project_1st/ipaddress.dart';
import 'package:flutter_project_1st/registerID.dart';
import 'package:flutter_project_1st/settingpage/theme/theme_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import './../consttants.dart';
import './../widgets/two_side_rounded_button.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;
import 'package:http/http.dart' as http;

import 'PdfPreviewScreen.dart';

class ReadingListCard extends StatefulWidget {
  final String image;
  final String title;
  final String categ;
  final VoidCallback pressDetails;
  final VoidCallback pressRead;
  final bool isFree;
  final String pdfFilePath;
  final int itemId;
  final bool isFavorite;
  const ReadingListCard({
    super.key,
    required this.image,
    required this.title,
    required this.categ,
    required this.pressDetails,
    required this.pressRead,
    required this.isFree,
    required this.pdfFilePath,
    required this.itemId,
    required this.isFavorite,
  });

  @override
  State<ReadingListCard> createState() => _ReadingListCardState();
}

class _ReadingListCardState extends State<ReadingListCard> {
  void _launchURL() async {
    try {
      await OpenFile.open(widget.pdfFilePath);
    } catch (e) {
      print('Error opening file: $e');
    }
  }


  bool _isFavorite = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isFavorite = widget.isFavorite;
  }

  Future<void> addfavorite({
    required String registerID,
    required String iditem,
    required BuildContext context,
    required String softCopy,
  }) async {
    final ipAddress = await getLocalIPv4Address();
    final url = Uri.parse('http://$ipAddress:3000/addfavorite');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'registerID': registerID,
          'iditem': iditem,
          'softCopy': softCopy,
        },
      );

      if (response.statusCode == 200) {
        // Data sent successfully
        setState(() {
          _isFavorite = true; // Update the local state
        });
        print('added successful');
      } else {
        print('HTTP error: ${response.statusCode}');
      }
    } catch (error) {
      // Handle network or other errors
      print('Error: $error');
    }
  }

  Future<void> deletefavorite({
    required String iditem,
    required BuildContext context,
    required String registerid,
  }) async {
    final ipAddress = await getLocalIPv4Address();
    final url = Uri.parse('http://$ipAddress:3000/deletefavorite');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {'iditem': iditem, 'registerID': registerid},
      );

      if (response.statusCode == 200) {
        // Data sent successfully
        setState(() {
          _isFavorite = false; // Update the local state
        });
        print('Deleted successful');
      } else {
        print('HTTP error: ${response.statusCode}');
      }
    } catch (error) {
      // Handle network or other errors
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final userData = Provider.of<UserData>(context);
    final registerID = userData.registerID;
    return Container(
      margin: EdgeInsets.only(left: 24, bottom: 40),
      height: 320,
      width: 202,
      child: Stack(
        children: <Widget>[
          Container(
            height: 250,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(29),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 10),
                  blurRadius: 33,
                  color: kShadowColor,
                ),
              ],
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(29),
              topRight: Radius.circular(29),
            ),
            child: Image.asset(
              widget.image,
              width: double.infinity,
              //height: double.maxFinite,
            ),
          ),
          Visibility(
            visible: !widget.isFree,
            child: Positioned(
              left: 8,
              top: 4,
              child: Icon(
                CommunityMaterialIcons.crown,
                color: kIconColor,
                size: 35,
              ),
            ),
          ),
          Positioned(
            right: 8,
            top: 4,
            child: GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(
                            20.0), // Adjust the radius as needed
                        topRight: Radius.circular(20.0),
                      ),
                      child: Container(
                        color: themeProvider.isDarkMode
                            ? Colors.black87
                            : Color(0xFFffffff),
                        //color: Colors.white,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, top: 18),
                              child: ListTile(
                                leading: Icon(
                                  Icons.preview,
                                  size: 25,
                                  color: themeProvider.isDarkMode
                                      ? Colors.white
                                      : Colors.black,
                                ),
                                title: Text(
                                  S.of(context).Preview,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    color: themeProvider.isDarkMode
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                                onTap: () async {
                                  Navigator.pop(context);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => PdfPreviewScreen(
                                            pdfFilePath: widget.pdfFilePath),
                                      ));
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: ListTile(
                                leading: Icon(
                                  Icons.download,
                                  size: 25,
                                  color: themeProvider.isDarkMode
                                      ? Colors.white
                                      : Colors.black,
                                ),
                                title: Text(
                                  S.of(context).Download,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    color: themeProvider.isDarkMode
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                                onTap: () {
                                  Navigator.pop(context);
                                  print("path");
                                  print(widget.pdfFilePath);
                                  _launchURL();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              child: Icon(
                CommunityMaterialIcons.drag_horizontal_variant,
                color: Colors.white,
                size: 35,
              ),
            ),
          ),
          Positioned(
              right: 8,
              top: 30,
              child: GestureDetector(
                onTap: () async {
                  setState(() {
                    _isFavorite = !_isFavorite;
                    print(_isFavorite);
                  });
                  if (_isFavorite) {
                    await addfavorite(
                        registerID: registerID,
                        context: context,
                        iditem: widget.itemId.toString(),
                        softCopy: '1');
                  } else {
                    await deletefavorite(
                        context: context,
                        iditem: widget.itemId.toString(),
                        registerid: registerID);
                  }
                },
                child: Icon(
                  _isFavorite ? Icons.favorite : Icons.favorite_border,
                  size: 30,
                  color: Colors.white,
                ),
              )),
          Positioned(
            top: 205,
            child: Container(
              height: 85,
              width: 202,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 24),
                      child: RichText(
                          maxLines: 2,
                          text: TextSpan(
                              style: TextStyle(color: kBlackColor),
                              children: [
                                TextSpan(
                                  text: widget.title + '\n',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text: widget.categ,
                                  style: TextStyle(
                                    color: kLightBlackColor,
                                  ),
                                ),
                              ])),
                    ),
                    Spacer(),
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}
