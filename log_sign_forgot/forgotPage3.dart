import 'package:flutter/material.dart';
import 'package:flutter_project_1st/log_sign_forgot/custom_confirm_password.dart';
import 'package:flutter_project_1st/log_sign_forgot/custom_password_field.dart';
import 'package:flutter_project_1st/log_sign_forgot/loginpage.dart';

class forgotPage3 extends StatelessWidget {
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController confirmcontroller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String password = '';
  String confirmPassword = '';
  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Scaffold(
        // resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new_outlined, // Back arrow icon
              color: Colors.white, // Change the color
              size: 30.0, // Change the size
            ), // Back arrow icon
            onPressed: () {
              Navigator.pop(context); // Return to the previous page
            },
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                // end: Alignment.bottomRight,
                colors: [
                  Color(0xFF228559),
                  Color(0xFF088053),
                ], // Define your gradient colors here
              ),
            ),
          ),
        ),
        body: Container(
            // padding: EdgeInsets.symmetric(vertical: 0),
            width: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(begin: Alignment.topCenter, colors: [
              Color(0xFF228559),
              Color(0xFF17573b),
            ])),
            child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Center(
                            child: Text("Create New Password",
                                style: TextStyle(
                                    color: Color(0xFFffffff), fontSize: 33)),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Form(
                        key: _formKey,
                        child: Container(
                            child: Container(
                                decoration: BoxDecoration(
                                    color: Color(0xFFffffff),
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(60),
                                        topRight: Radius.circular(60))),
                                child: Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Column(
                                    children: <Widget>[
                                      SizedBox(
                                        height: 80,
                                      ),
                                      Container(
                                        child: Column(
                                          children: <Widget>[
                                            Center(
                                              child: Text(
                                                "Your New Password Must Be Different from Previously Used Password.",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xFF000000),
                                                  fontSize: 18,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 40,
                                            ),
                                            PasswordTextField(
                                              controller: passwordcontroller,
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            ConfirmPasswordTextField(
                                              controller: confirmcontroller,
                                              controllerpass:
                                                  passwordcontroller,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 40,
                                      ),
                                      Container(
                                          height: 60,
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 50),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            color: Color(0xFF33c787),
                                          ),
                                          child: TextButton(
                                              onPressed: () {
                                                // Get the values from the text fields

                                                // Check if both fields are not empty
                                                if (_formKey.currentState!
                                                    .validate()) {
                                                  // Form is valid, perform your login action here

                                                  // Perform the login action
                                                  // You can navigate to the next page or handle login logic here
                                                  Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              login()));
                                                }
                                              },
                                              child: Center(
                                                child: Text(
                                                  "Save",
                                                  style: TextStyle(
                                                      color: Color(0xFFffffff),
                                                      fontSize: 30,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ))),
                                      SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                )))),
                  ]),
            )));
  }
}
