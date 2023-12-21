import 'package:flutter/material.dart';
import 'package:flutter_project_1st/additems/CustomFacultyDropMenu.dart';

class addItem3 extends StatefulWidget {
  final double containerHeight;
  final double containerWidth;
  final Function(int) onFacultySelected;
  final Function(int) onMajoritySelected;
  const addItem3({
    super.key,
    required this.containerHeight,
    required this.containerWidth,
    required this.onFacultySelected,
    required this.onMajoritySelected,
  });

  @override
  State<addItem3> createState() => _addItem3State();
}

class _addItem3State extends State<addItem3> {
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
