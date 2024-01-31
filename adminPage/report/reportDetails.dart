import 'package:flutter/material.dart';
import 'package:flutter_project_1st/adminPage/report/reportClass.dart';
import 'package:flutter_project_1st/adminPage/users/responsive.dart';
import 'package:flutter_project_1st/offers/offerAppBar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_project_1st/ipaddress.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class ReportDetailsPage extends StatefulWidget {
  final Report report;

  const ReportDetailsPage({Key? key, required this.report}) : super(key: key);

  @override
  State<ReportDetailsPage> createState() => _ReportDetailsPageState();
}

class _ReportDetailsPageState extends State<ReportDetailsPage> {
  TextEditingController lname = TextEditingController();
  TextEditingController fname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController studentID = TextEditingController();
  TextEditingController phoneNO = TextEditingController();
  TextEditingController idreport = TextEditingController();
  TextEditingController reportcomment = TextEditingController();
  TextEditingController itemId = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController image = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController faculty = TextEditingController();
  TextEditingController major = TextEditingController();

  bool isObscurePassword = false;

  @override
  void initState() {
    super.initState();
    // Call the function to fetch and load report data when the screen is initialized
    fetchAndLoadReportData(widget.report.itemId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: appBarOffers(),
      ),
      backgroundColor: Colors.white,
      //drawer: SideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                          Image.network(
                            widget.report.image ?? 'N/A',
                            width: kIsWeb ? 560 : 260,
                            height: kIsWeb ? 300 : 200,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          buildTextField(
                            controller: idreport,
                            labelText: "Report ID",
                            placeHolder: "Report ID",
                            isPasswordTextField: false,
                          ),
                          buildTextField(
                            controller: reportcomment,
                            labelText: "Comment",
                            placeHolder: "Comment",
                            isPasswordTextField: false,
                          ),
                          buildTextField(
                            controller: itemId,
                            labelText: "Item ID",
                            placeHolder: "Item ID",
                            isPasswordTextField: false,
                          ),
                          buildTextField(
                            controller: title,
                            labelText: "Item Name",
                            placeHolder: "Item Name",
                            isPasswordTextField: false,
                          ),
                          buildTextField(
                            controller: description,
                            labelText: "Description",
                            placeHolder: "Description",
                            isPasswordTextField: false,
                          ),
                          buildTextField(
                            controller: price,
                            labelText: "Price",
                            placeHolder: "Price",
                            isPasswordTextField: false,
                          ),
                          buildTextField(
                            controller: fname,
                            labelText: "First Name",
                            placeHolder: "First Name",
                            isPasswordTextField: false,
                          ),
                          buildTextField(
                            controller: lname,
                            labelText: "Last Name",
                            placeHolder: "Last Name",
                            isPasswordTextField: false,
                          ),
                          buildTextField(
                            controller: studentID,
                            labelText: "Student ID",
                            placeHolder: "Student ID",
                            isPasswordTextField: false,
                          ),
                          buildTextField(
                            controller: faculty,
                            labelText: "Faculty",
                            placeHolder: "Faculty",
                            isPasswordTextField: false,
                          ),
                          buildTextField(
                            controller: major,
                            labelText: "Major",
                            placeHolder: "Major",
                            isPasswordTextField: false,
                          ),
                          buildTextField(
                            controller: password,
                            labelText: "Password",
                            placeHolder: "Password",
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
                            controller: phoneNO,
                            labelText: "Phone Number",
                            placeHolder: "Phone Number",
                            isPasswordTextField: false,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            if (!Responsive.isMobile(context)) SizedBox(width: 16.0),
          ],
        ),
      ),
    );
  }

  void fetchAndLoadReportData(int itemId) async {
    //final studentIdToEdit = ;
    final ipAddress = await getLocalIPv4Address();
    final itemUrl = Uri.parse('http://$ipAddress:3000/reportadmin');

    try {
      final response = await http.get(itemUrl);
      print(response.body);
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);
        final List<Report> reports =
            jsonData.map((data) => Report.fromJson(data)).toList();
        setState(() {
          this.idreport.text = "  " + reports.first.idreport.toString();
          this.reportcomment.text = "  " + reports.first.reportcomment;
          this.itemId.text = "  " + reports.first.itemId.toString();
          this.title.text = "  " + (reports.first.title ?? 'N/A').toString();
          this.description.text =
              "  " + (reports.first.description ?? 'N/A').toString();
          this.price.text = "  " + reports.first.price.toString() + " ₪";
          print(widget.report.email);
          print(reports.first.email);
          this.fname.text = "  " + (reports.first.fname ?? 'N/A').toString();
          this.lname.text = "  " + (reports.first.lname ?? 'N/A').toString();
          this.password.text =
              "  " + (reports.first.password ?? 'N/A').toString();
          this.email.text = "  " + (reports.first.email ?? 'N/A').toString();
          this.studentID.text =
              "  " + (reports.first.registerID ?? 'N/A').toString();
          this.phoneNO.text =
              "  " + (reports.first.phoneNumber ?? 'N/A').toString();
          this.faculty.text =
              "  " + (reports.first.faculty ?? 'N/A').toString();
          this.major.text = "  " + (reports.first.major ?? 'N/A').toString();
          this.image.text = reports.first.image ?? 'N/A';
        });
        print('Student data loaded successfully');
      } else {
        print('Failed to fetch student data: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
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
      child: TextFormField(
        controller: controller,
        readOnly: true, // Make the text field non-editable
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
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF17573b)),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }
}
