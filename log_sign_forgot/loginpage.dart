import 'package:flutter/material.dart';
import 'package:flutter_project_1st/homepage/hidden_drawer.dart';
import 'package:flutter_project_1st/ipaddress.dart';
import 'package:flutter_project_1st/log_sign_forgot/custom_RegisterID_field.dart';
import 'package:flutter_project_1st/log_sign_forgot/custom_password_field.dart';
import 'package:flutter_project_1st/log_sign_forgot/forgotPage1.dart';
import 'package:flutter_project_1st/log_sign_forgot/signupPage.dart';
import 'package:flutter_project_1st/registerID.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _registerIdController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String errorMessage = '';
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
                      padding: EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Center(
                            child: Text("LOGIN",
                                style: TextStyle(
                                    color: Color(0xFFffffff), fontSize: 40)),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: Text("Welcome Back!",
                                style: TextStyle(
                                    color: Color(0xFFffffff), fontSize: 20)),
                          )
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
                                            RegisterIDTextField(
                                              controller: _registerIdController,
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            PasswordTextField(
                                              controller: _passwordController,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        errorMessage,
                                        style: TextStyle(
                                          color: Color(0xFFf25a46),
                                          fontSize: 16,
                                          backgroundColor: Color.fromARGB(
                                              255, 240, 192, 186),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      forgotPage1()));
                                        },
                                        child: Text(
                                          "Forgot Password?",
                                          style: TextStyle(
                                              color: Color(0xFF228559),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
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
                                              onPressed: () async {
                                                // Get the values from the text fields

                                                // Check if both fields are not empty
                                                if (_formKey.currentState!
                                                    .validate()) {
                                                  // Form is valid, perform your login action here

                                                  // Perform the login action
                                                  // You can navigate to the next page or handle login logic here
                                                  final registerId =
                                                      _registerIdController
                                                          .text;
                                                  final password =
                                                      _passwordController.text;
                                                  await logIn(
                                                    registerID: registerId,
                                                    password: password,
                                                    context: context,
                                                  );
                                                }
                                              },
                                              child: Center(
                                                child: Text(
                                                  "Login",
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
                                      Center(
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: 45,
                                            ),
                                            Text(
                                              "Don't have an account?",
                                              style: TextStyle(
                                                  color: Color(0xFF000000),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            signup()));
                                              },
                                              child: Text(
                                                "Sign up",
                                                style: TextStyle(
                                                    color: Color(0xFF228559),
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )))),
                  ]),
            )));
  }

  Future<void> logIn({
    required String registerID,
    required String password,
    required BuildContext context,
  }) async {
    final userData = Provider.of<UserData>(context, listen: false);
    userData.setRegisterID(registerID);
    print("RegisterID");
    print(registerID);
    final ipAddress = await getLocalIPv4Address();
    // print("***********ipAddress:" + ipAddress);
    final url = Uri.parse(
        'http://$ipAddress:3000/login'); // Replace with your login endpoint
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'registerID': registerID,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        // Successful login, handle the response from the server
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HiddenDrawer(page: 0,)));
        print('Login successful');
      } else if (response.statusCode == 401) {
        // Incorrect password
        print('Incorrect password');
        setState(() {
          errorMessage = 'Your password is incorrect.';
        });
      } else if (response.statusCode == 404) {
        // User not found
        print('User not found');
        setState(() {
          errorMessage = 'This account doesn\'t exist. Please Sign up first.';
        });
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
