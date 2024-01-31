import 'package:flutter/material.dart';
import 'package:flutter_project_1st/adminPage/users/model/user.dart';
import 'package:flutter_project_1st/adminPage/users/responsive.dart';
import 'package:flutter_project_1st/adminPage/users/utils/styles.dart';
import 'package:flutter_project_1st/ipaddress.dart';
import 'package:flutter_project_1st/offers/offerAppBar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UpdateStudentScreen extends StatefulWidget {
  final User user;

  const UpdateStudentScreen({Key? key, required this.user}) : super(key: key);
  static const String id = "updatestudent";

  @override
  State<UpdateStudentScreen> createState() => _UpdateStudentScreenState();
}

class _UpdateStudentScreenState extends State<UpdateStudentScreen> {
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
  void initState() {
    super.initState();
    // Call the function to fetch and load student data when the screen is initialized
    fetchAndLoadStudentData(widget.user.ID);
  }

  @override
  Widget build(BuildContext context) {
    const defaultPadding = 16.0;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: appBarOffers(),
      ),
      //drawer: SideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // We want this side menu only for large screen
            // if (Responsive.isDesktop(context))
            //   Expanded(
            //     // default flex = 1
            //     // and it takes 1/6 part of the screen
            //     child: c,
            //   ),
            Expanded(
              // It takes 5/6 part of the screen
              flex: 5,
              child: SingleChildScrollView(
                child: Container(
                  child: Center(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 17, vertical: 7),
                      child: Column(
                        children: [
                          SizedBox(height: defaultPadding),
                          const Text(
                            "Update Student Information",
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
                          // EcoButton(
                          //   title: "UPDATE",
                          //   isLoginButton: true,
                          //   onPress: () {
                          //     save();
                          //   },
                          //   isLoading: isSaving,
                          // ),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              OutlinedButton(
                                onPressed: () {
                                  Navigator.pop(
                                    context,
                                  );
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
                                        content: Text(
                                            'Student updated successfully'),
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

  void fetchAndLoadStudentData(int studentIdToEdit) async {
    //final studentIdToEdit = ;
    final ipAddress = await getLocalIPv4Address();
    final fetchStudentUrl =
        Uri.parse('http://$ipAddress:3000/getstudent/$studentIdToEdit');

    try {
      final response = await http.get(fetchStudentUrl);

      if (response.statusCode == 200) {
        final studentData = jsonDecode(response.body);
        setState(() {
          this.lname.text = widget.user.LastName;
          this.fname.text = widget.user.firstName;
          this.studentID.text = widget.user.ID.toString();
          this.phoneNO.text = widget.user.phoneNO;
          this.email.text = widget.user.email;
          print("Phone Numberrr:" + widget.user.phoneNO);
          //this.password.text = widget.user.password;
        });
        print(studentIdToEdit);
        print('Student data loaded successfully');
      } else {
        print('Failed to fetch student data: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  void save() async {
    print('Update button pressed');
    // Validate inputs before proceeding
    if (lname.text.isEmpty ||
        fname.text.isEmpty ||
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
    print('****************** ${lname.text} ${fname.text}');
    try {
      setState(() {
        isSaving = true;
      });

      final ipAddress = await getLocalIPv4Address();
      final updateUrl = Uri.parse('http://$ipAddress:3000/updatestudent');

      final response = await http.put(
        updateUrl,
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'registerID': widget.user.ID.toString(),
          'newstudentID': studentID.text,
          'fname': fname.text,
          'lname': lname.text,
          'phoneNO': phoneNO.text,
          'password': password.text,
          'email': email.text,
        },
      );

      if (response.statusCode == 200) {
        // Handle success
        print('Student updated successfully');
      } else {
        // Handle error
        print('Failed to update student: ${response.statusCode}');
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
}
