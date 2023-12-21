import 'package:flutter/material.dart';
import 'package:flutter_project_1st/additems/CustomCategoryDropMenu.dart';
import 'package:flutter_project_1st/additems/CustomPhoneNumber.dart';
import 'package:flutter_project_1st/additems/CustomStatusDropMenu.dart';

class addItem2 extends StatefulWidget {
  const addItem2({
    super.key,
    required this.containerHeight,
    required this.containerWidth,
    required this.onCategorySelected,
    required this.onStatusSelected,
    required this.phoneNumber,
  });
  final double containerHeight;
  final double containerWidth;
  final Function(int) onCategorySelected;
  final Function(int) onStatusSelected;
  final Function(String) phoneNumber;

  @override
  State<addItem2> createState() => _addItem2State();
}

class _addItem2State extends State<addItem2> {
  late int _selectedCategoryRadio;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CategoryDropDown(
          containerHeight: widget.containerHeight,
          containerWidth: widget.containerWidth,
          onCategorySelected: (selectedRadio) {
            // Handle the selected radio value here
            _selectedCategoryRadio = selectedRadio;
            print('Selected Category: $selectedRadio');
            print('_selectedCategoryRadio: $_selectedCategoryRadio');
            widget.onCategorySelected(selectedRadio);
          },
        ),
        SizedBox(
          height: 25,
        ),
        StatusDropDown(
          containerHeight: widget.containerHeight,
          containerWidth: widget.containerWidth,
          onStatusSelected: (selectedRadio) {
            print('Selected Status: $selectedRadio');
            widget.onStatusSelected(selectedRadio);
          },
        ),
        SizedBox(
          height: 25,
        ),
        phoneNumberTxetfield(
          containerHeight: widget.containerHeight,
          containerWidth: widget.containerWidth,
          onPhoneNumberChanged: (newPhoneNumber) {
            // Handle the new phone number value here
            print('New Phone Number: $newPhoneNumber');
            widget.phoneNumber(newPhoneNumber);
          },
        ),
        SizedBox(
          height: 35,
        ),
      ],
    );
  }
}
