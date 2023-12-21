import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_project_1st/accountpaage/otherUserAccount.dart';

class CustomResultNotification extends StatefulWidget {
  const CustomResultNotification({
    super.key,
    required this.useriamge,
    required this.fName,
    required this.lName,
    required this.itemTitle,
    required this.itemId,
    required this.itemOwner,
    required this.desicion,
    required this.themeProvider,
    required this.price,
  });
  final String useriamge;
  final String fName;
  final String lName;
  final String itemTitle;
  final String itemId;
  final String itemOwner;
  final String desicion;
  final String price;
  final themeProvider;

  @override
  State<CustomResultNotification> createState() =>
      _CustomResultNotificationState();
}

class _CustomResultNotificationState extends State<CustomResultNotification> {
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
                     bool desicion=false;
                    if(widget.desicion == '1'){
                      desicion=true;

                    }else{
                      desicion=false;
                    }
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => otherUserAccountPage(
                                  userRegisterID: widget.itemOwner,
                                  flagReserved: false,
                                  itemTitle: widget.itemTitle,
                                  itemId: widget.itemId,
                                  goNotification: true,
                                  flagReservedResult: true,
                                  desicion: desicion,
                                  price: widget.price,
                                )));
                  },
                  child: Container(
                    width: 300,
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 16,
                          //color: Colors.black87,
                          color: widget.themeProvider.isDarkMode
                              ? Color(0xFFffffff)
                              : Colors.black87,
                        ),
                        children: [
                          TextSpan(
                            text: widget.fName + " " + widget.lName + ",",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: (widget.desicion == '1'
                                ? " accepted" +
                                    " your reserved request for " +
                                    widget.itemTitle +
                                    "."
                                : " I apologize because " +
                                    widget.itemTitle +
                                    " was assigned to someone else."),
                            style: const TextStyle(
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
