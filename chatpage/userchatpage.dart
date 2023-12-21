import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_project_1st/accountpaage/otherUserAccount.dart';
import 'package:flutter_project_1st/chatpage/chatpage.dart';
import 'package:flutter_project_1st/generated/l10n.dart';
import 'package:flutter_project_1st/homepage/hidden_drawer.dart';
import 'package:flutter_project_1st/ipaddress.dart';
import 'package:flutter_project_1st/settingpage/theme/theme_provider.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'Message.dart';
import 'package:http/http.dart' as http;

class UserChatPage extends StatefulWidget {
  const UserChatPage(
      {super.key,
      required this.senderId,
      required this.receiverId,
      required this.receiverFname,
      required this.receiverLname,
      required this.gotoChat});
  final String senderId;
  final String receiverId;
  final String receiverFname;
  final String receiverLname;
  final bool gotoChat;

  @override
  State<UserChatPage> createState() => _UserChatPageState();
}

class _UserChatPageState extends State<UserChatPage> {
  TextEditingController messageController = TextEditingController();
  List<Message> messages = [];
  String Profileimage = '';
  @override
  void initState() {
    super.initState();
    initializeData();
  }

  Future<void> initializeData() async {
    try {
      print("inside initializeData");
      await fetchProfileImage(widget.receiverId);
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
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
        backgroundColor:
            themeProvider.isDarkMode ? Colors.black12 : Color(0xFFffffff),
        appBar: _buildAppBar(themeProvider),
        body: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(widget.senderId)
                    .collection(widget.receiverId)
                    .orderBy('date', descending: false)
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  messages = snapshot.data!.docs
                      .map((DocumentSnapshot document) => Message.fromMap(
                          document.data() as Map<String, dynamic>))
                      .toList();

                  return GroupedListView<Message, DateTime>(
                    padding: const EdgeInsets.all(8),
                    reverse: true,
                    order: GroupedListOrder.DESC,
                    useStickyGroupSeparators: true,
                    floatingHeader: true,
                    elements: messages,
                    groupBy: (message) => DateTime(
                      message.date.year,
                      message.date.month,
                      message.date.day,
                    ),
                    groupHeaderBuilder: (Message message) => SizedBox(
                      height: 40,
                      child: Center(
                        child: Card(
                          color: Color(0xFFc0edda),
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              DateFormat.yMMMd().format(message.date),
                              style: const TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ),
                    itemBuilder: (context, Message message) => Align(
                      alignment: message.isSentByme
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 8),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: message.isSentByme
                              ? const Color(0xFF117a5d).withOpacity(0.8)
                              : const Color(0xFFffffff).withOpacity(0.8),
                          borderRadius: message.isSentByme
                              ? const BorderRadius.only(
                                  topRight: Radius.circular(30),
                                  bottomLeft: Radius.circular(30),
                                  topLeft: Radius.circular(30))
                              : const BorderRadius.only(
                                  topRight: Radius.circular(30),
                                  bottomRight: Radius.circular(30),
                                  topLeft: Radius.circular(30)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 2,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                        child: Text(
                          message.text,
                          style: TextStyle(
                            color: message.isSentByme
                                ? Colors.white
                                : Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: themeProvider.isDarkMode
                              ? Colors.black.withOpacity(0.8)
                              : Colors.white.withOpacity(0.8),
                          //color: Colors.white.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 2,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                        child: TextField(
                          controller: messageController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(12),
                            hintText: S.of(context).Type_msg,
                            hintStyle: TextStyle(
                              color: themeProvider.isDarkMode
                                  ? Colors.white
                                  : Colors.black,
                            ),
                            border:
                                OutlineInputBorder(borderSide: BorderSide.none),
                          ),
                          // onSubmitted: (text) {
                          //   final message = Message(
                          //     text: text,
                          //     date: DateTime.now(),
                          //     isSentByme: true,
                          //   );
                          //   setState(() {
                          //     messages.add(message);
                          //     messageController.clear();
                          //   });
                          // },
                        ),
                      ),
                    ),
                    SizedBox(
                        width:
                            12), // Add some space between TextField and button
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFF117a5d),
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.send_rounded,
                          size: 28,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          final text = messageController.text;
                          if (text.isNotEmpty) {
                            // final message = Message(
                            //   text: text,
                            //   date: DateTime.now(),
                            //   isSentByme: true,
                            // );
                            _sendText(context);
                            setState(() {
                              //messages.add(message);
                              messageController.clear();
                            });
                          }
                        },
                      ),
                    ),
                  ],
                )),
          ],
        ));
  }

  AppBar _buildAppBar(themeProvider) => AppBar(
        elevation: 0,
        //foregroundColor: Color(0xFF117a5d).withOpacity(0.9),
        backgroundColor: Color(0xFF117a5d).withOpacity(0.8),
        leading: IconButton(
          onPressed: () {
            if (widget.gotoChat) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HiddenDrawer(
                            page: 2,
                          )));
              print(messages);
            } else {
              Navigator.pop(context);
            }
          },
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
            color:
                themeProvider.isDarkMode ? Colors.black : Colors.grey.shade200,
            //color: Colors.grey.shade200,
            size: 30,
          ),
        ),
        title: Row(
          children: [
            CircleAvatar(
              radius: 25,
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
            const SizedBox(
              width: 10,
            ),
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => otherUserAccountPage(
                                  userRegisterID: widget.receiverId.toString(),
                                  flagReserved: false,
                                  itemTitle: '',
                                  itemId: '',
                                  goNotification: false,
                                  desicion: false,
                                  flagReservedResult: false,
                                  price: " ",
                                )));
                  },
                  child: Text(
                    widget.receiverFname + " " + widget.receiverLname,
                    style: TextStyle(
                      color: themeProvider.isDarkMode
                          ? Colors.black
                          : Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      );

  Future<void> _sendText(BuildContext context) async {
    try {
      final text = messageController.text;
      if (text.isNotEmpty) {
        final senderCollection = FirebaseFirestore.instance
            .collection('users')
            .doc(widget.senderId)
            .collection(widget.receiverId);

        final receiverCollection = FirebaseFirestore.instance
            .collection('users')
            .doc(widget.receiverId)
            .collection(widget.senderId);

        // Add the message to sender's collection
        await senderCollection.add({
          'text': text,
          'date': DateTime.now(),
          'isSentByMe': true,
        });

        // Add the message to receiver's collection
        await receiverCollection.add({
          'text': text,
          'date': DateTime.now(),
          'isSentByMe': false,
        });

        // Clear the text field and update the UI
        setState(() {
          final message = Message(
            text: text,
            date: DateTime.now(),
            isSentByme: true,
          );
          messages.add(message);
          messageController.clear();
          print(messages);
        });
      }
    } catch (error) {
      print('Error sending message: $error');
      // Handle the error, show a snackbar, etc.
    }
  }
}
