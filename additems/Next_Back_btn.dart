import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_project_1st/categorise/furniturepage/Furniturepage.dart';
import 'package:flutter_project_1st/generated/l10n.dart';
import 'package:flutter_project_1st/homepage/hidden_drawer.dart';
import 'package:flutter_project_1st/ipaddress.dart';
import 'package:flutter_project_1st/registerID.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class Next_Back_btn extends StatefulWidget {
  final int CurrentStep;
  final bool isLastStep;
  final ControlsDetails details;
  final String itemnameController;
  final String priceController;
  final String DescriptionController;
  final int selectRadioCategory;
  final int selectRadioStatus;
  final int selectRadioFaculty;
  final int selectRadioMajority;
  final String phoneNumber;
  final File? selectedImage;
  const Next_Back_btn({
    super.key,
    required this.CurrentStep,
    required this.isLastStep,
    required this.details,
    required this.itemnameController,
    required this.priceController,
    required this.DescriptionController,
    required this.selectRadioCategory,
    required this.selectRadioStatus,
    required this.phoneNumber,
    required this.selectRadioFaculty,
    required this.selectRadioMajority,
    required this.selectedImage,
  });

  @override
  State<Next_Back_btn> createState() => _Next_Back_btnState();
}

class _Next_Back_btnState extends State<Next_Back_btn> {
  String errorMessage = '';
  String registerid = '';

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserData>(context);
    final registerID = userData.registerID;
    registerid = registerID;
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 0),
      child: Column(
        children: [
          if (errorMessage.isNotEmpty)
            Text(
              errorMessage,
              style: TextStyle(
                color: Colors.red,
                fontSize: 16,
              ),
            ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 60,
                  margin: EdgeInsets.only(
                    right: 10,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Color.fromARGB(255, 233, 233, 233),
                  ),
                  child: TextButton(
                      onPressed: () {
                        if (widget.CurrentStep == 0) {
                          Navigator.pop(context);
                        } else {
                          widget.details.onStepCancel!();
                        }
                      },
                      child: Center(
                        child: Text(
                          widget.CurrentStep == 0 ? S.of(context).Cancel : S.of(context).Back,
                          style: TextStyle(
                              color: Color(0xFF000000),
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                      )),
                ),
              ),
              Expanded(
                child: Container(
                  height: 60,
                  margin: EdgeInsets.only(
                    left: 10,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: const Color(0xFF117a5d).withOpacity(0.85),
                  ),
                  child: TextButton(
                      onPressed: () async {
                        if (widget.CurrentStep == 0) {
                          if (widget.itemnameController.isEmpty ||
                              widget.priceController.isEmpty ||
                              widget.selectedImage == null) {
                            setState(() {
                              errorMessage = 'All fields are required.';
                              print(errorMessage);
                            });
                            return;
                          }
                        } else if (widget.CurrentStep == 1) {
                          if (widget.selectRadioCategory == 0 ||
                              widget.selectRadioStatus == 0 ||
                              widget.phoneNumber == " ") {
                            setState(() {
                              errorMessage = 'All fields are required.';
                              print(errorMessage);
                            });
                            return;
                          }
                        } else if (widget.CurrentStep == 2) {
                          if (widget.selectRadioFaculty == 0 ||
                              widget.selectRadioMajority == 0) {
                            setState(() {
                              errorMessage = 'All fields are required.';
                              print(errorMessage);
                            });
                            return;
                          }
                        }
                        errorMessage = '';
                        widget.details.onStepContinue!();
                        print("item name controller:");
                        print(widget.itemnameController);
                        print("price controller:");
                        print(widget.priceController);
                        print("Description controller:");
                        print(widget.DescriptionController);
                        print("selectRadioCategory:");
                        print(widget.selectRadioCategory);
                        print("selectRadioStatus:");
                        print(widget.selectRadioStatus);
                        print("phoneNumber:");
                        print(widget.phoneNumber);
                        print("selectRadioFaculty:");
                        print(widget.selectRadioFaculty);
                        print("selectRadioMajority:");
                        print(widget.selectRadioMajority);
                        print("RegisterID");
                        print(registerID);
                        print("iamge picker");
                        print(widget.selectedImage);
                        if (widget.isLastStep) {
                          await addItem(
                            itemnameController: widget.itemnameController,
                            priceController: widget.priceController,
                            DescriptionController: widget.DescriptionController,
                            selectRadioCategory: widget.selectRadioCategory,
                            selectRadioStatus: widget.selectRadioStatus,
                            selectRadioFaculty: widget.selectRadioFaculty,
                            selectRadioMajority: widget.selectRadioMajority,
                            phoneNumber: widget.phoneNumber,
                            context: context,
                          );
                        }
                      },
                      child: Center(
                        child: Text(
                          widget.isLastStep ? S.of(context).Upload: S.of(context).Next,
                          style: TextStyle(
                              color: Color(0xFFffffff),
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                      )),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> addItem({
    required String itemnameController,
    required String priceController,
    required String DescriptionController,
    required int selectRadioCategory,
    required int selectRadioStatus,
    required String phoneNumber,
    required int selectRadioFaculty,
    required int selectRadioMajority,
    required BuildContext context,
  }) async {
    final ipAddress = await getLocalIPv4Address();
    final url = Uri.parse('http://$ipAddress:3000/addItem');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'registerID': registerid,
          'idCategory': selectRadioCategory.toString(),
          'title': itemnameController,
          'description': DescriptionController,
          'price': priceController,
          'available': '1',
          'status': selectRadioStatus.toString(),
          'phoneNumber': phoneNumber,
          'faculty': selectRadioFaculty.toString(),
          'major': selectRadioMajority.toString(),
          'image': widget.selectedImage?.path.toString() ?? '',
        },
      );

      if (response.statusCode == 200) {
        // Data sent successfully
        print('upload successful');
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HiddenDrawer(page:0)));
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
