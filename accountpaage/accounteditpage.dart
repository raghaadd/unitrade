import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_project_1st/generated/l10n.dart';
import 'package:flutter_project_1st/homepage/hidden_drawer.dart';
import 'package:flutter_project_1st/ipaddress.dart';
import 'package:flutter_project_1st/registerID.dart';
import 'package:flutter_project_1st/settingpage/theme/theme_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'accountpage.dart';

class editAccount extends StatefulWidget {
  editAccount({
    Key? key,
    required this.fName,
    required this.lName,
    required this.major,
    required this.about,
    required this.profileImage,
  }) : super(key: key);
  String fName;
  String lName;
  String major;
  String about;
  String profileImage;

  @override
  State<editAccount> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<editAccount> {
  final TextEditingController fNameController = TextEditingController();
  final TextEditingController lNameController = TextEditingController();
  final TextEditingController majorController = TextEditingController();
  final TextEditingController aboutController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Future<void> editprofileinfo({
    required String registerID,
    required String fName,
    required String lName,
    required String major,
    required String about,
  }) async {
    final ipAddress = await getLocalIPv4Address();
    final url = Uri.parse('http://$ipAddress:3000/editprofileInfo');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'registerID': registerID,
          if (fName.isNotEmpty) 'fname': fName else 'fname': widget.fName,
          if (lName.isNotEmpty) 'lname': lName else 'lname': widget.lName,
          if (major.isNotEmpty) 'major': major else 'major': widget.major,
          if (about.isNotEmpty) 'about': about else 'about': widget.about,
        },
      );

      if (response.statusCode == 200) {
        // Data sent successfully
        print('image inserted successfully');
        setState(() {
          widget.fName = fName.isNotEmpty ? fName : widget.fName;
          widget.lName = lName.isNotEmpty ? lName : widget.lName;
          widget.major = major.isNotEmpty ? major : widget.major;
          widget.about = about.isNotEmpty ? about : widget.about;
        });
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
    final userData = Provider.of<UserData>(context, listen: false);
    final registerID = userData.registerID;
    return Scaffold(
      backgroundColor:
          themeProvider.isDarkMode ? Colors.black54 : Color(0xFFffffff),
      body: Container(
        padding: EdgeInsets.only(left: 15, top: 20, right: 15),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                        border: Border.all(width: 4, color: Colors.white),
                        boxShadow: [
                          BoxShadow(
                              spreadRadius: 2,
                              blurRadius: 10,
                              color: Colors.black.withOpacity(0.3))
                        ],
                        shape: BoxShape.circle,

                        // image: DecorationImage(
                        //     fit: BoxFit.cover,
                        //     image: AssetImage("assets/background.jpg"))
                      ),
                      child: CircleAvatar(
                        radius: 55,
                        backgroundColor: Colors.grey.shade300,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            if (widget.profileImage.isEmpty)
                              Icon(
                                Icons.person,
                                size: 100,
                                color: Colors.white,
                              ),
                            if (widget.profileImage.isNotEmpty)
                              ClipOval(
                                child: Image.file(
                                  File(widget.profileImage),
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: double.infinity,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: SizedBox(
                        height: 46,
                        width: 46,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                              side: const BorderSide(color: Colors.white),
                            ),
                            backgroundColor: const Color(0xFFF5F6F9),
                          ),
                          onPressed: () {
                            print("pressed");
                          },
                          child: Image.asset("assets/camera.png"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              buildTextField(S.of(context).first_name, widget.fName,
                  fNameController, themeProvider),
              buildTextField(S.of(context).last_name, widget.lName,
                  lNameController, themeProvider),
              buildTextField(S.of(context).Major, widget.major, majorController,
                  themeProvider),
              buildTextField(S.of(context).About, widget.about, aboutController,
                  themeProvider),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      S.of(context).Cancel,
                      style: TextStyle(
                        fontSize: 20,
                        letterSpacing: 2,
                        color: themeProvider.isDarkMode
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await editprofileinfo(
                        registerID: registerID,
                        fName: fNameController.text,
                        lName: lNameController.text,
                        major: majorController.text,
                        about: aboutController.text,
                      );
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HiddenDrawer(page: 3)));
                    },
                    child: Text(
                      S.of(context).Save,
                      style: TextStyle(
                          fontSize: 20, letterSpacing: 2, color: Colors.white),
                    ),
                    style: OutlinedButton.styleFrom(
                        backgroundColor: Color(0xFF117a5d),
                        padding: EdgeInsets.symmetric(horizontal: 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String labelText, String placeHolder,
      TextEditingController controller, themeProvider) {
    return Padding(
      padding: EdgeInsets.only(bottom: 30),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(bottom: 5),
          labelText: labelText,
          labelStyle: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: themeProvider.isDarkMode ? Colors.white : Colors.black,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: placeHolder,
          hintStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Colors.black45), // Set your desired color
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
