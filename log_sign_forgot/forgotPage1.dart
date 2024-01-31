import 'package:flutter/material.dart';
import 'package:flutter_project_1st/ipaddress.dart';
import 'package:flutter_project_1st/log_sign_forgot/custom_email_field.dart';
import 'package:flutter_project_1st/log_sign_forgot/forgotPage2.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart' show kIsWeb;

// ignore: must_be_immutable
class forgotPage1 extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController passwordcontroller = TextEditingController();
  final TextEditingController _emailAddressController = TextEditingController();

  forgotPage1({super.key});
  @override
  Widget build(BuildContext context) {
    double containerWidth = MediaQuery.of(context).size.width;
    //double containerHieght = MediaQuery.of(context).size.heig
    // Size size = MediaQuery.of(context).size;
    return Scaffold(
        //resizeToAvoidBottomInset: false,
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
                            child: Text("Forgot Password",
                                style: TextStyle(
                                    color: Color(0xFFffffff), fontSize: 40)),
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
                                        // width: kIsWeb
                                        //     ? containerWidth * 0.4
                                        //     : containerWidth * 0.8,
                                        child: Column(
                                          children: <Widget>[
                                            Center(
                                              child: Text(
                                                "Please Enter Your Email Address To Recieve a Verification Code.",
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
                                            Container(
                                              width: kIsWeb
                                                  ? containerWidth * 0.4
                                                  : containerWidth * 0.8,
                                              child: EmailAddressTextField(
                                                controller:
                                                    _emailAddressController,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 40,
                                      ),
                                      Container(
                                          height: 60,
                                          width: kIsWeb
                                              ? containerWidth * 0.39
                                              : containerWidth * 0.85,
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 50),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            color: Color(0xFF33c787),
                                          ),
                                          child: TextButton(
                                              onPressed: () async {
                                                // Get the values from the text fields

                                                // Check if both fields are not empty
                                                if (_formKey.currentState!
                                                    .validate()) {
                                                  // Form is valid, perform your login action here
                                                  final email =
                                                      _emailAddressController
                                                          .text;
                                                  await Forgot1(
                                                    email: email,
                                                    context: context,
                                                  );
                                                }
                                              },
                                              child: Center(
                                                child: Text(
                                                  "Send",
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

  Future<void> Forgot1({
    required String email,
    required BuildContext context,
  }) async {
    final ipAddress = await getLocalIPv4Address();
    //print("***********ipAddress:" + ipAddress);
    final url = Uri.parse('http://$ipAddress:3000/sendVerificationCode');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'email': email,
        },
      );
      if (response.statusCode == 200) {
        // Successful login, handle the response from the server
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => forgotPage2(
                      email: email,
                    )));
        print('Forgot Password');
      } else if (response.statusCode == 401) {
        // Incorrect password
        print('Incorrect password');
      } else if (response.statusCode == 404) {
        // User not found
        print('User not found');
      } else {
        // Handle other errors or server responses based on status code
        print('HTTP error: ${response.statusCode}');
      }
    } catch (error) {
      // Handle network or other errors
      print('Error: $error');
    }
  }
}
