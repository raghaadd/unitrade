import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project_1st/log_sign_forgot/forgotPage3.dart';

class forgotPage2 extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
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
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                height: 68,
                                                width: 64,
                                                child: Container(
                                                  color: Color(0xFFc0edda),
                                                  child: TextFormField(
                                                    onChanged: (value) {
                                                      if (value.length == 1) {
                                                        FocusScope.of(context)
                                                            .nextFocus();
                                                      }
                                                    },
                                                    onSaved: (pin1) {},
                                                    decoration: InputDecoration(
                                                      hintText: "0",
                                                      focusedBorder:
                                                          UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Color(
                                                                0xFF33c787)),
                                                      ),
                                                      enabledBorder:
                                                          UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Color(
                                                                0xFF33c787)),
                                                      ),
                                                    ),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline6!
                                                        .copyWith(
                                                            fontSize: 25,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                    keyboardType:
                                                        TextInputType.number,
                                                    textAlign: TextAlign.center,
                                                    inputFormatters: [
                                                      LengthLimitingTextInputFormatter(
                                                          1),
                                                      FilteringTextInputFormatter
                                                          .digitsOnly,
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 68,
                                                width: 64,
                                                child: Container(
                                                  color: Color(0xFFc0edda),
                                                  child: TextFormField(
                                                    onChanged: (value) {
                                                      if (value.length == 1) {
                                                        FocusScope.of(context)
                                                            .nextFocus();
                                                      }
                                                    },
                                                    onSaved: (pin2) {},
                                                    decoration: InputDecoration(
                                                      hintText: "0",
                                                      focusedBorder:
                                                          UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Color(
                                                                0xFF33c787)),
                                                      ),
                                                      enabledBorder:
                                                          UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Color(
                                                                0xFF33c787)),
                                                      ),
                                                    ),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline6!
                                                        .copyWith(
                                                            fontSize: 25,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                    keyboardType:
                                                        TextInputType.number,
                                                    textAlign: TextAlign.center,
                                                    inputFormatters: [
                                                      LengthLimitingTextInputFormatter(
                                                          1),
                                                      FilteringTextInputFormatter
                                                          .digitsOnly,
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 68,
                                                width: 64,
                                                child: Container(
                                                  color: Color(0xFFc0edda),
                                                  child: TextFormField(
                                                    onChanged: (value) {
                                                      if (value.length == 1) {
                                                        FocusScope.of(context)
                                                            .nextFocus();
                                                      }
                                                    },
                                                    onSaved: (pin3) {},
                                                    decoration: InputDecoration(
                                                      hintText: "0",
                                                      focusedBorder:
                                                          UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Color(
                                                                0xFF33c787)),
                                                      ),
                                                      enabledBorder:
                                                          UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Color(
                                                                0xFF33c787)),
                                                      ),
                                                    ),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline6!
                                                        .copyWith(
                                                            fontSize: 25,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                    keyboardType:
                                                        TextInputType.number,
                                                    textAlign: TextAlign.center,
                                                    inputFormatters: [
                                                      LengthLimitingTextInputFormatter(
                                                          1),
                                                      FilteringTextInputFormatter
                                                          .digitsOnly,
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 68,
                                                width: 64,
                                                child: Container(
                                                  color: Color(0xFFc0edda),
                                                  child: TextFormField(
                                                    onChanged: (value) {
                                                      if (value.length == 1) {
                                                        FocusScope.of(context)
                                                            .nextFocus();
                                                      }
                                                    },
                                                    onSaved: (pin4) {},
                                                    decoration: InputDecoration(
                                                      hintText: "0",
                                                      focusedBorder:
                                                          UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Color(
                                                                0xFF33c787)),
                                                      ),
                                                      enabledBorder:
                                                          UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Color(
                                                                0xFF33c787)),
                                                      ),
                                                    ),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline6!
                                                        .copyWith(
                                                            fontSize: 25,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                    keyboardType:
                                                        TextInputType.number,
                                                    textAlign: TextAlign.center,
                                                    inputFormatters: [
                                                      LengthLimitingTextInputFormatter(
                                                          1),
                                                      FilteringTextInputFormatter
                                                          .digitsOnly,
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
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
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            forgotPage3()));
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
}
