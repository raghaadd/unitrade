import 'package:flutter/material.dart';
import 'package:flutter_project_1st/adminPage/users/Student_table.dart';
import 'package:flutter_project_1st/adminPage/users/responsive.dart';
import 'package:flutter_project_1st/adminPage/users/utils/styles.dart';

import 'package:flutter_project_1st/ipaddress.dart';
import 'package:http/http.dart' as http;

class addStudentScreen extends StatefulWidget {
  const addStudentScreen({super.key});
  static const String id = "addstudentD";

  @override
  State<addStudentScreen> createState() => _addStudentScreenState();
}

class _addStudentScreenState extends State<addStudentScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController lname = TextEditingController();
  TextEditingController fname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController studentID = TextEditingController();
  TextEditingController phoneNO = TextEditingController();

  String? selectedValue;
  bool isSaving = false;
  bool isUploading = false;

  bool isObscurePassword = false;
  @override
  Widget build(BuildContext context) {
    const defaultPadding = 16.0;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      // drawer: SideMenu(),
      body: SafeArea(
        child: Row(
          //backgroundColor: Colors.white,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // if (!Responsive.isDesktop(context))
            //   IconButton(
            //     icon: Icon(Icons.menu),
            //     onPressed: () {
            //       // Wrap the context using Builder
            //       Builder(
            //         builder: (context) {
            //           // Now, this context contains the Provider<MenuAppController>
            //           context.read<MenuAppController>().controlMenu();
            //           return SizedBox(); // Return a placeholder widget here
            //         },
            //       );
            //     },
            //   ),

            // We want this side menu only for large screen
            // if (Responsive.isDesktop(context))
            //   // Expanded(
            //   //   // default flex = 1
            //   //   // and it takes 1/6 part of the screen
            //   //  // child: SideMenu(),
            //   // ),
            Expanded(
              // It takes 5/6 part of the screen
              // flex: 6,
              child: SingleChildScrollView(
                child: Container(
                  child: Center(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 17, vertical: 7),
                      child: Column(
                        children: [
                          // Header(),
                          SizedBox(height: defaultPadding),
                          const Text(
                            "Add New Student",
                            style: EcoStyle.boldStyle,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          buildTextField(
                            controller: fname,
                            labelText: "First Name",
                            placeHolder: "Given Name",
                            isPasswordTextField: false,
                          ),
                          buildTextField(
                            controller: lname,
                            labelText: "Last Name",
                            placeHolder: "Family Name",
                            isPasswordTextField: false,
                          ),
                          buildTextField(
                            controller: password,
                            labelText: "Password",
                            placeHolder: "*******",
                            isPasswordTextField: true,
                            onEyeIconPressed: togglePasswordVisibility,
                          ),
                          buildTextField(
                            controller: email,
                            labelText: "E-mail",
                            placeHolder: "E-mail",
                            isPasswordTextField: false,
                          ),
                          buildTextField(
                            controller: studentID,
                            labelText: "Student ID",
                            placeHolder: "Student ID",
                            isPasswordTextField: false,
                          ),
                          buildTextField(
                            controller: phoneNO,
                            labelText: "Phone Number",
                            placeHolder: "Phone Number",
                            isPasswordTextField: false,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              OutlinedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  "CANCEL",
                                  style: TextStyle(
                                      fontSize: 15,
                                      letterSpacing: 2,
                                      color: Colors.black),
                                ),
                                style: OutlinedButton.styleFrom(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 50),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20))),
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  save();
                                  bool saveSuccessful = true;

                                  if (saveSuccessful) {
                                    // Show SnackBar
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content:
                                            Text('Student saved successfully'),
                                        duration: Duration(seconds: 5),
                                      ),
                                    );
                                  }
                                },
                                child: Text(
                                  "SAVE",
                                  style: TextStyle(
                                      fontSize: 15,
                                      letterSpacing: 2,
                                      color: Colors.white),
                                ),
                                style: OutlinedButton.styleFrom(
                                    backgroundColor: Color(0xFF17573b),
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 50),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20))),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            if (!Responsive.isMobile(context)) SizedBox(width: defaultPadding),
          ],
        ),
      ),
    );
  }

  void togglePasswordVisibility() {
    setState(() {
      isObscurePassword = !isObscurePassword;
    });
  }

  Widget buildTextField({
    required TextEditingController controller,
    required String labelText,
    required String placeHolder,
    required bool isPasswordTextField,
    VoidCallback? onEyeIconPressed,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 30),
      child: TextField(
        controller: controller,
        obscureText: isPasswordTextField && !isObscurePassword,
        decoration: InputDecoration(
          suffixIcon: isPasswordTextField
              ? IconButton(
                  icon: Icon(Icons.remove_red_eye, color: Colors.grey),
                  onPressed: onEyeIconPressed,
                )
              : null,
          contentPadding: EdgeInsets.only(bottom: 5),
          labelText: labelText,
          labelStyle: TextStyle(
            fontSize: 19,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: placeHolder,
          hintStyle: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }

  void save() async {
    print('Save button pressed');
    // Validate inputs before proceeding
    if (fname.text.isEmpty ||
        lname.text.isEmpty ||
        studentID.text.isEmpty ||
        phoneNO.text.isEmpty ||
        email.text.isEmpty ||
        password.text.isEmpty) {
      // Display an error message or handle validation as needed
      print('Please fill in all fields');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill in all fields'),
          duration: Duration(seconds: 5),
        ),
      );
      return;
    }
    print('****************** ${fname.text} ${lname.text}');
    try {
      setState(() {
        isSaving = true;
      });

      final ipAddress = await getLocalIPv4Address();
      final saveUrl = Uri.parse('http://$ipAddress:3000/addstudent');

      final response = await http.post(
        saveUrl,
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'registerID': studentID.text,
          'fname': fname.text,
          'lname': lname.text,
          'phoneNO': phoneNO.text,
          'password': password.text,
          'email': email.text,
        },
      );

      if (response.statusCode == 200) {
        // Handle success
        print('Student saved successfully');
      } else {
        // Handle error
        print('Failed to save student: ${response.statusCode}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('The student already exists'),
            duration: Duration(seconds: 5),
          ),
        );
      }
    } catch (error) {
      // Handle any exceptions
      print('Error: $error');
    } finally {
      setState(() {
        isSaving = false;
      });
    }
  }
}
