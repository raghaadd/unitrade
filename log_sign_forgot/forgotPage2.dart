import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project_1st/ipaddress.dart';
import 'package:flutter_project_1st/log_sign_forgot/forgotPage3.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:http/http.dart' as http;

class forgotPage2 extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  forgotPage2({super.key, required this.email});
  final String email;

  @override
  Widget build(BuildContext context) {
    double containerWidth = MediaQuery.of(context).size.width;
    TextEditingController pin1Controller = TextEditingController();
    TextEditingController pin2Controller = TextEditingController();
    TextEditingController pin3Controller = TextEditingController();
    TextEditingController pin4Controller = TextEditingController();
    TextEditingController codeController = TextEditingController();
    return Scaffold(
        resizeToAvoidBottomInset: false,
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
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Center(
                          child: Text("Verify Your Email",
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
                      child: Expanded(
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
                                              "Please Enter The 4 Digit Code Sent To Your Email.",
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
                                          TextField(
                                            controller: codeController,
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              hintText: "Verification Code",
                                              hintStyle: TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                            style: TextStyle(
                                              color: Colors
                                                  .black, // Set your desired text color here
                                            ),
                                          ),
                                          // Row(
                                          //   mainAxisAlignment: kIsWeb
                                          //       ? MainAxisAlignment.center
                                          //       : MainAxisAlignment
                                          //           .spaceBetween,
                                          //   children: [
                                          //     SizedBox(
                                          //       height: 68,
                                          //       width: 64,
                                          //       child: Container(
                                          //         color: Color(0xFFc0edda),
                                          //         child: TextFormField(
                                          //           controller: pin1Controller,
                                          //           onChanged: (value) {
                                          //             if (value.length == 1) {
                                          //               FocusScope.of(context)
                                          //                   .nextFocus();
                                          //             }
                                          //           },
                                          //           onSaved: (pin1) {},
                                          //           decoration: InputDecoration(
                                          //             hintText: "0",
                                          //             focusedBorder:
                                          //                 UnderlineInputBorder(
                                          //               borderSide: BorderSide(
                                          //                   color: Color(
                                          //                       0xFF33c787)),
                                          //             ),
                                          //             enabledBorder:
                                          //                 UnderlineInputBorder(
                                          //               borderSide: BorderSide(
                                          //                   color: Color(
                                          //                       0xFF33c787)),
                                          //             ),
                                          //           ),
                                          //           style: Theme.of(context)
                                          //               .textTheme
                                          //               .headline6!
                                          //               .copyWith(
                                          //                   fontSize: 25,
                                          //                   fontWeight:
                                          //                       FontWeight
                                          //                           .bold),
                                          //           keyboardType:
                                          //               TextInputType.number,
                                          //           textAlign: TextAlign.center,
                                          //           inputFormatters: [
                                          //             LengthLimitingTextInputFormatter(
                                          //                 1),
                                          //             FilteringTextInputFormatter
                                          //                 .digitsOnly,
                                          //           ],
                                          //         ),
                                          //       ),
                                          //     ),
                                          //     SizedBox(
                                          //       height: 68,
                                          //       width: 64,
                                          //       child: Container(
                                          //         color: Color(0xFFc0edda),
                                          //         child: TextFormField(
                                          //           controller: pin2Controller,
                                          //           onChanged: (value) {
                                          //             if (value.length == 1) {
                                          //               FocusScope.of(context)
                                          //                   .nextFocus();
                                          //             }
                                          //           },
                                          //           onSaved: (pin2) {},
                                          //           decoration: InputDecoration(
                                          //             hintText: "0",
                                          //             focusedBorder:
                                          //                 UnderlineInputBorder(
                                          //               borderSide: BorderSide(
                                          //                   color: Color(
                                          //                       0xFF33c787)),
                                          //             ),
                                          //             enabledBorder:
                                          //                 UnderlineInputBorder(
                                          //               borderSide: BorderSide(
                                          //                   color: Color(
                                          //                       0xFF33c787)),
                                          //             ),
                                          //           ),
                                          //           style: Theme.of(context)
                                          //               .textTheme
                                          //               .headline6!
                                          //               .copyWith(
                                          //                   fontSize: 25,
                                          //                   fontWeight:
                                          //                       FontWeight
                                          //                           .bold),
                                          //           keyboardType:
                                          //               TextInputType.number,
                                          //           textAlign: TextAlign.center,
                                          //           inputFormatters: [
                                          //             LengthLimitingTextInputFormatter(
                                          //                 1),
                                          //             FilteringTextInputFormatter
                                          //                 .digitsOnly,
                                          //           ],
                                          //         ),
                                          //       ),
                                          //     ),
                                          //     SizedBox(
                                          //       height: 68,
                                          //       width: 64,
                                          //       child: Container(
                                          //         color: Color(0xFFc0edda),
                                          //         child: TextFormField(
                                          //           controller: pin3Controller,
                                          //           onChanged: (value) {
                                          //             if (value.length == 1) {
                                          //               FocusScope.of(context)
                                          //                   .nextFocus();
                                          //             }
                                          //           },
                                          //           onSaved: (pin3) {},
                                          //           decoration: InputDecoration(
                                          //             hintText: "0",
                                          //             focusedBorder:
                                          //                 UnderlineInputBorder(
                                          //               borderSide: BorderSide(
                                          //                   color: Color(
                                          //                       0xFF33c787)),
                                          //             ),
                                          //             enabledBorder:
                                          //                 UnderlineInputBorder(
                                          //               borderSide: BorderSide(
                                          //                   color: Color(
                                          //                       0xFF33c787)),
                                          //             ),
                                          //           ),
                                          //           style: Theme.of(context)
                                          //               .textTheme
                                          //               .headline6!
                                          //               .copyWith(
                                          //                   fontSize: 25,
                                          //                   fontWeight:
                                          //                       FontWeight
                                          //                           .bold),
                                          //           keyboardType:
                                          //               TextInputType.number,
                                          //           textAlign: TextAlign.center,
                                          //           inputFormatters: [
                                          //             LengthLimitingTextInputFormatter(
                                          //                 1),
                                          //             FilteringTextInputFormatter
                                          //                 .digitsOnly,
                                          //           ],
                                          //         ),
                                          //       ),
                                          //     ),
                                          //     SizedBox(
                                          //       height: 68,
                                          //       width: 64,
                                          //       child: Container(
                                          //         color: Color(0xFFc0edda),
                                          //         child: TextFormField(
                                          //           controller: pin4Controller,
                                          //           onChanged: (value) {
                                          //             if (value.length == 1) {
                                          //               FocusScope.of(context)
                                          //                   .nextFocus();
                                          //             }
                                          //           },
                                          //           onSaved: (pin4) {},
                                          //           decoration: InputDecoration(
                                          //             hintText: "0",
                                          //             focusedBorder:
                                          //                 UnderlineInputBorder(
                                          //               borderSide: BorderSide(
                                          //                   color: Color(
                                          //                       0xFF33c787)),
                                          //             ),
                                          //             enabledBorder:
                                          //                 UnderlineInputBorder(
                                          //               borderSide: BorderSide(
                                          //                   color: Color(
                                          //                       0xFF33c787)),
                                          //             ),
                                          //           ),
                                          //           style: Theme.of(context)
                                          //               .textTheme
                                          //               .headline6!
                                          //               .copyWith(
                                          //                   fontSize: 25,
                                          //                   fontWeight:
                                          //                       FontWeight
                                          //                           .bold),
                                          //           keyboardType:
                                          //               TextInputType.number,
                                          //           textAlign: TextAlign.center,
                                          //           inputFormatters: [
                                          //             LengthLimitingTextInputFormatter(
                                          //                 1),
                                          //             FilteringTextInputFormatter
                                          //                 .digitsOnly,
                                          //           ],
                                          //         ),
                                          //       ),
                                          //     ),
                                          //   ],
                                          // ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 40,
                                    ),
                                    Container(
                                        width: kIsWeb
                                            ? containerWidth * 0.4
                                            : containerWidth * 0.39,
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
                                              String verificationCode =
                                                  pin1Controller.text +
                                                      pin2Controller.text +
                                                      pin3Controller.text +
                                                      pin4Controller.text;
                                              print("verificationCode;;;;;;" +
                                                  codeController.text);
                                              // Check if both fields are not empty
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                Forgot2(
                                                    context: context,
                                                    code: codeController.text,
                                                    email: this.email);
                                                // Form is valid, perform your login action here

                                                // Perform the login action
                                                // You can navigate to the next page or handle login logic here
                                              }
                                            },
                                            child: Center(
                                              child: Text(
                                                "Verfiy",
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
                ])));
  }

  Future<void> Forgot2({
    required String email,
    required String code,
    required BuildContext context,
  }) async {
    final ipAddress = await getLocalIPv4Address();
    //print("***********ipAddress:" + ipAddress);
    final url = Uri.parse('http://$ipAddress:3000/verifyCode');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'email': email,
          'code': code,
        },
      );
      if (response.statusCode == 200) {
        // Successful login, handle the response from the server
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => forgotPage3(email: this.email,)));
        print('verfiy Password');
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
