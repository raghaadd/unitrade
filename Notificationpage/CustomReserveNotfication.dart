import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_project_1st/accountpaage/otherUserAccount.dart';
import 'package:flutter_project_1st/ipaddress.dart';
import 'package:http/http.dart' as http;

import 'CustomAlertConten.dart';

class CustomReserveNotfication extends StatefulWidget {
  const CustomReserveNotfication({
    super.key,
    required this.useriamge,
    required this.fName,
    required this.lName,
    required this.itemTitle,
    required this.itemId,
    required this.itemRequester,
    required this.onDecisionMade,
    required this.themeProvider,
  });
  final String useriamge;
  final String fName;
  final String lName;
  final String itemTitle;
  final String itemId;
  final String itemRequester;
  final Function(String itemId, String itemRequester) onDecisionMade;
  final themeProvider;

  @override
  State<CustomReserveNotfication> createState() =>
      _CustomReserveNotficationState();
}

class _CustomReserveNotficationState extends State<CustomReserveNotfication> {
  int decision = 0;

  Future<void> addDecision({
    required String iditem,
    required int decision,
    required String itemRequester,
  }) async {
    final ipAddress = await getLocalIPv4Address();
    final url = Uri.parse('http://$ipAddress:3000/addDecision');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'iditem': iditem,
          'decision': decision.toString(),
          'itemRequester': itemRequester
        },
      );

      if (response.statusCode == 200) {
        // Data sent successfully
        print('Reserved successfully');
        widget.onDecisionMade(
            widget.itemId.toString(), widget.itemRequester.toString());
        setState(() {});
      } else if (response.statusCode == 400) {
        print("400 error");
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Text(
                      'Reserved Alert',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 16),
                  CustomAlertContent(
                      alertText:
                          "This item already reserved for another person"),
                  SizedBox(height: 16),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context); // Close Dialog
                      },
                      child: Text(
                        'OK',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF117a5d),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: Color(0xFF117a5d).withOpacity(0.5),
              child: ClipOval(
                child: Image.file(
                  File(widget.useriamge),
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => otherUserAccountPage(
                                  userRegisterID: widget.itemRequester,
                                  flagReserved: true,
                                  itemTitle: widget.itemTitle,
                                  itemId: widget.itemId,
                                  goNotification: true,
                                  flagReservedResult: false,
                                  desicion: false,
                                  price: "0",
                                )));
                  },
                  child: Text(
                    widget.fName + " " + widget.lName,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: widget.themeProvider.isDarkMode
                          ? Color(0xFFffffff)
                          : Colors.black87,
                      //color: Colors.black87,
                    ),
                  ),
                ),
                Text(
                  "New reserved for " + widget.itemTitle + " item",
                  style: TextStyle(
                    fontSize: 14,
                    color: widget.themeProvider.isDarkMode
                        ? Color(0xFFffffff)
                        : Colors.black54,
                  ),
                ),
              ],
            ),
          ],
        ),
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: widget.themeProvider.isDarkMode
                      ? Colors.black12
                      : Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 3,
                      offset: const Offset(0, 2),
                    ),
                  ]),
              child: IconButton(
                onPressed: () async {
                  decision = 1;
                  print(decision);
                  await addDecision(
                      decision: decision,
                      iditem: widget.itemId.toString(),
                      itemRequester: widget.itemRequester);
                },
                icon: const Icon(
                  Icons.check,
                  size: 25,
                  color: Color(0xFF117a5d),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: widget.themeProvider.isDarkMode
                      ? Colors.black12
                      : Colors.white,
                  //color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 3,
                      offset: const Offset(0, 2),
                    ),
                  ]),
              child: IconButton(
                onPressed: () async {
                  decision = 0;
                  print(decision);
                  await addDecision(
                      decision: decision,
                      iditem: widget.itemId.toString(),
                      itemRequester: widget.itemRequester);
                  //widget.onDecisionMade(widget.itemId.toString(), widget.itemRequester.toString());
                },
                icon: const Icon(
                  Icons.close,
                  size: 25,
                  color: Color.fromARGB(255, 141, 24, 18),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
