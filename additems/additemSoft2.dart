import 'package:flutter/material.dart';
import 'package:flutter_project_1st/additems/CustomCategoryDropMenu.dart';
import 'package:flutter_project_1st/additems/CustomPhoneNumber.dart';
import 'package:flutter_project_1st/additems/CustomeFree.dart';

class addItemSoft2 extends StatefulWidget {
  const addItemSoft2({
    super.key,
    required this.containerHeight,
    required this.containerWidth,
    required this.onCategorySelected,
    required this.freecheckBox,
    required this.phoneNumber,
    required TextEditingController priceController,
  }) : _priceController = priceController;
  final double containerHeight;
  final double containerWidth;
  final Function(int) onCategorySelected;
  final Function(int) freecheckBox;
  final Function(String) phoneNumber;
  final TextEditingController _priceController;

  @override
  State<addItemSoft2> createState() => _addItemSoft2State();
}

class _addItemSoft2State extends State<addItemSoft2> {
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
        FreeDropDown(
          containerHeight: widget.containerHeight,
          containerWidth: widget.containerWidth,
          itempriceController: widget._priceController,
          freecheckBox: (checkBox) {
            print('checkBox: $checkBox');
            widget.freecheckBox(checkBox);
          },
          priceController: (price) {
            print(price);
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
