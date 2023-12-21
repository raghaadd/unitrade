import 'package:flutter/material.dart';
import 'package:flutter_project_1st/additems/CustomFacultyDropMenu.dart';

class addItemSoft3 extends StatefulWidget {
  final double containerHeight;
  final double containerWidth;
  final Function(int) onFacultySelected;
  final Function(int) onMajoritySelected;
  const addItemSoft3({
    super.key,
    required this.containerHeight,
    required this.containerWidth,
    required this.onFacultySelected,
    required this.onMajoritySelected,
  });

  @override
  State<addItemSoft3> createState() => _addItemSoft3State();
}

class _addItemSoft3State extends State<addItemSoft3> {
  bool isExpanded = false;
  int selectedRadio = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FacutyDropDown(
            containerHeight: widget.containerHeight,
            containerWidth: widget.containerWidth,
            onFacultySelected: (selectedRadio) {
              widget.onFacultySelected(selectedRadio);
            },
            onMajoritySelected: (selectedRadio) {
              widget.onMajoritySelected(selectedRadio);
            }),
        SizedBox(
          height: 25,
        ),
        SizedBox(
          height: 35,
        ),
      ],
    );
  }

  Widget buildRadioListTile(String title, int value) {
    return RadioListTile(
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          color: Colors.grey.shade800,
        ),
      ),
      value: value,
      groupValue: selectedRadio,
      onChanged: (newValue) {
        setState(() {
          selectedRadio = newValue as int;
        });
      },
    );
  }
}
