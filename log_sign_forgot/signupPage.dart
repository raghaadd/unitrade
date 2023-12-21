import 'package:flutter/material.dart';
import 'package:flutter_project_1st/ipaddress.dart';
import 'package:flutter_project_1st/log_sign_forgot/custom_FName_field.dart';
import 'package:flutter_project_1st/log_sign_forgot/custom_RegisterID_field.dart';
import 'package:flutter_project_1st/log_sign_forgot/custom_email_field.dart';
import 'package:flutter_project_1st/log_sign_forgot/custom_password_field.dart';
import 'package:flutter_project_1st/log_sign_forgot/custom_phoneno_field.dart';
import 'package:flutter_project_1st/log_sign_forgot/custome_LName_field.dart';
import 'package:flutter_project_1st/log_sign_forgot/loginpage.dart';
import 'package:http/http.dart' as http;

class signup extends StatefulWidget {
  @override
  _signupState createState() => _signupState();
}

class _signupState extends State<signup> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _registerIdController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _emailAddressController = TextEditingController();
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
                      padding: EdgeInsets.all(2),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Center(
                            child: Text("SIGN UP",
                                style: TextStyle(
                                    color: Color(0xFFffffff), fontSize: 40)),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: Text("Create an account",
                                style: TextStyle(
                                    color: Color(0xFFffffff), fontSize: 20)),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8,
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
                                        height: 20,
                                      ),
                                      Container(
                                        child: Column(
                                          children: <Widget>[
                                            RegisterIDTextField(
                                              controller: _registerIdController,
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            FirstNameTextField(
                                              controller: _firstNameController,
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            LastNameTextField(
                                              controller: _lastNameController,
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            PhoneNumberTextField(
                                              controller:
                                                  _phoneNumberController,
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            EmailAddressTextField(
                                              controller:
                                                  _emailAddressController,
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            PasswordTextField(
                                              controller: _passwordController,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        errorMessage,
                                        style: TextStyle(
                                          color: Color(0xFFf25a46),
                                          fontSize: 16,
                                          backgroundColor: Color.fromARGB(
                                              255, 240, 192, 186),
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(
                                        height: 5,
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
                                                  final firstName =
                                                      _firstNameController.text;
                                                  final lastName =
                                                      _lastNameController.text;
                                                  final phoneNumber =
                                                      _phoneNumberController
                                                          .text;
                                                  final email =
                                                      _emailAddressController
                                                          .text;
                                                  final password =
                                                      _passwordController.text;
                                                  await signUp(
                                                    registerID: registerId,
                                                    fname: firstName,
                                                    lname: lastName,
                                                    phoneNO: phoneNumber,
                                                    email: email,
                                                    password: password,
                                                    context: context,
                                                  );
                                                  await createProfile(
                                                    registerID: registerId,
                                                  );
                                                }
                                              },
                                              child: Center(
                                                child: Text(
                                                  "Sign Up",
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
                                              "Already have an account?",
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
                                                            login()));
                                              },
                                              child: Text(
                                                "Login",
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
                                ))))
                  ]),
            )));
  }

  Future<void> signUp({
    required String registerID,
    required String fname,
    required String lname,
    required String phoneNO,
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    final ipAddress = await getLocalIPv4Address();
    final url = Uri.parse('http://$ipAddress:3000/signup');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'registerID': registerID,
          'fname': fname,
          'lname': lname,
          'phoneNO': phoneNO,
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        // Data sent successfully
        print('Signup successful');
        // Navigator.pushReplacement(
        //     context, MaterialPageRoute(builder: (context) => login()));
      } else {
        // Handle errors or server response based on status code
        setState(() {
          errorMessage =
              'This account doesn\'t exist. You can try logging in with your register ID';
        });
        print('HTTP error: ${response.statusCode}');
      }
    } catch (error) {
      // Handle network or other errors
      print('Error: $error');
    }
  }


  Future<void> createProfile({
    required String registerID,
  }) async {
    final ipAddress = await getLocalIPv4Address();
    final url = Uri.parse('http://$ipAddress:3000/createprofile');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'registerID': registerID,
        },
      );

      if (response.statusCode == 200) {
        // Data sent successfully
        print('profile craeted successful');
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => login()));
      } else {
        // Handle errors or server response based on status code
        setState(() {
          errorMessage =
              'This account doesn\'t exist. You can try logging in with your register ID';
        });
        print('HTTP error: ${response.statusCode}');
      }
    } catch (error) {
      // Handle network or other errors
      print('Error: $error');
    }
  }
}
