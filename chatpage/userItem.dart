import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_project_1st/ipaddress.dart';

import 'UserModel.dart';
import 'userchatpage.dart';
import 'package:http/http.dart' as http;

class userItem extends StatefulWidget {
  const userItem(
      {super.key,
      required this.user,
      required this.registerId,
      required this.themeProvider});
  final UserModel user;
  final String registerId;
  final themeProvider;

  @override
  State<userItem> createState() => _userItemState();
}

class _userItemState extends State<userItem> {
  String Profileimage = '';
  @override
  void initState() {
    super.initState();
    initializeData();
  }

  Future<void> initializeData() async {
    try {
      print("inside initializeData");
      await fetchProfileImage(widget.user.uid);
    } catch (error) {
      // Handle errors
      print('Error initializing data: $error');
    }
  }

  Future<void> fetchProfileImage(String registerID) async {
    print("inside fetchProfileInfo");
    final ipAddress = await getLocalIPv4Address();
    final url = Uri.parse('http://$ipAddress:3000/profileimage/$registerID');

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

          final profileimage = firstItem['profileimage'];

          setState(() {
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

  @override
  Widget build(BuildContext context) => ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        radius: 30,
        backgroundColor: Colors.grey.shade300,
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (Profileimage.isEmpty)
              Icon(
                Icons.person,
                size: 100,
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
      title: Text(
        widget.user.Fname + " " + widget.user.Lname,
        style: TextStyle(
          color: widget.themeProvider.isDarkMode
              ? Color(0xFFffffff)
              : Color(0xFF000000),
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        widget.user.lastmessgae,
        style: TextStyle(
          color: widget.themeProvider.isDarkMode
              ? Color(0xFFffffff)
              : Colors.black45,
          fontSize: 15,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      trailing: Text(
        widget.user.date,
        style: TextStyle(
          color: widget.themeProvider.isDarkMode
              ? Color(0xFFffffff)
              : Color(0xFF000000),
          fontSize: 15,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      onTap: () {
        // Navigate to UserChatPage with the selected user
        print(widget.registerId);
        print(widget.user.uid);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UserChatPage(
              senderId: widget.registerId,
              receiverId: widget.user.uid,
              receiverFname: widget.user.Fname,
              receiverLname: widget.user.Lname,
              gotoChat: true,
            ),
          ),
        );
      });
}
