import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_1st/chatpage/UserModel.dart';
import 'package:flutter_project_1st/chatpage/userItem.dart';
import 'package:flutter_project_1st/generated/l10n.dart';
import 'package:flutter_project_1st/ipaddress.dart';
import 'package:flutter_project_1st/registerID.dart';
import 'package:flutter_project_1st/settingpage/theme/theme_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class chatpage extends StatefulWidget {
  const chatpage({super.key});

  @override
  State<chatpage> createState() => _chatpageState();
}

class _chatpageState extends State<chatpage> with TickerProviderStateMixin {
  String errorMessage = '';
  String receiverId = '';
  String receiverFname = '';
  String receiverLname = '';
  String registerid = '';
  List<User> userList = [];
  final List<UserModel> userData = [];

  @override
  void initState() {
    super.initState();
    // Assuming fetchUserData and chatpagefetch are asynchronous
    initializeData();
  }

  Future<void> initializeData() async {
    try {
      final userData = Provider.of<UserData>(context, listen: false);
      final registerID = userData.registerID;
      registerid = registerID;

      if (registerID != null) {
        print("inside initializeData");
        print(registerID);
        await chatpagefetch(registerID: registerID);
        await fetchUserData(registerID: registerID);
      } else {
        // Handle the case where registerID is null
        print('RegisterID is null.');
      }
    } catch (error) {
      // Handle errors
      print('Error initializing data: $error');
    }
  }

  Future<void> chatpagefetch({
    required String registerID,
  }) async {
    try {
      final ipAddress = await getLocalIPv4Address();
      final url = Uri.parse('http://$ipAddress:3000/userchat/$registerID');
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      );

      if (response.statusCode == 200) {
        // Parse the JSON response
        final jsonResponse = json.decode(response.body);

        // Check if the response has the 'registerID' field
        if (jsonResponse is List && jsonResponse.isNotEmpty) {
          // Clear the existing list before adding new data
          userList.clear();

          // Iterate over the list and add each user to the list
          for (var userData in jsonResponse) {
            final registerId = userData['registerID'];
            final fname = userData['Fname'];
            final lname = userData['Lname'];

            // Create a User object and add it to the list
            userList.add(User(
              registerID: registerId,
              fname: fname,
              lname: lname,
            ));
          }
          // print('Receiver ID: $receiverId');
        } else {
          // Handle unexpected response format
          setState(() {
            errorMessage = 'Invalid response format';
          });
          print('Invalid response format');
        }
      }
    } catch (error) {
      // Handle network or other errors
      print('Error: $error');
    }
  }

  Future<void> fetchUserData({
    required String registerID,
  }) async {
    try {
      for (var user in userList) {
        print("hi");
        final DocumentReference<Map<String, dynamic>> userDocRef =
            FirebaseFirestore.instance.collection('users').doc(registerID);
        final CollectionReference<Map<String, dynamic>> receiverCollection =
            userDocRef.collection(user.registerID.toString());
        final Query<Map<String, dynamic>> query =
            receiverCollection.orderBy('date', descending: true).limit(1);

        final QuerySnapshot<Map<String, dynamic>> receiverDocuments =
            await query.get();
        if (receiverDocuments.docs.isNotEmpty) {
          // Access the last document's data
          final DocumentSnapshot<Map<String, dynamic>> lastDocument =
              receiverDocuments.docs.first;

          DateTime dateTime;
          if (lastDocument['date'] is Timestamp) {
            dateTime = (lastDocument['date'] as Timestamp).toDate();
          } else {
            // Handle the case where 'date' is not a Timestamp (e.g., it's already a DateTime)
            dateTime = lastDocument['date'];
          }

          int hour = dateTime.hour;
          int minute = dateTime.minute;

          // Create a formatted time string (e.g., "hh:mm")
          String formattedTime = '$hour:${minute.toString().padLeft(2, '0')}';

          // Create a new UserModel instance using data from the user
          final UserModel userModel = UserModel(
            uid: user.registerID.toString(), // Assuming uid is a String
            Fname: user.fname,
            Lname: user.lname,
            image: " ",
            lastmessgae: lastDocument['text'],
            date: formattedTime,
          );
          setState(() {
            userData.add(userModel);
          });
        } else {
          print('No documents found in the subcollection.');
        }
      }
    } catch (error) {
      print('Error fetching user data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    setState(() {});
    return Scaffold(
        backgroundColor:
            themeProvider.isDarkMode ? Colors.black54 : Color(0xFFffffff),
        body: Column(
          children: [
            Container(
              padding:
                  const EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 8),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      S.of(context).Recent_chats,
                      style: TextStyle(
                          color: themeProvider.isDarkMode
                              ? Color(0xFFffffff)
                              : Color(0xFF000000),
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                    Icon(
                      Icons.search,
                      size: 30,
                      color: themeProvider.isDarkMode
                          ? Color(0xFFffffff)
                          : Color(0xFF000000),
                    )
                  ]),
            ),
            Expanded(
              child: ListView.separated(
                itemCount: userData.length,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                separatorBuilder: (context, index) => const SizedBox(
                  height: 10,
                ),
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) =>
                    userItem(user: userData[index], registerId: registerid,themeProvider:themeProvider),
              ),
            ),
          ],
        ));
  }
}

class User {
  final int registerID;
  final String fname;
  final String lname;

  User({required this.registerID, required this.fname, required this.lname});
}
