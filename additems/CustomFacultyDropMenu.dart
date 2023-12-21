import 'package:flutter/material.dart';
import 'package:flutter_project_1st/additems/CustomMajorDropMenu.dart';

class FacutyDropDown extends StatefulWidget {
  final double containerHeight;
  final double containerWidth;
  final Function(int) onFacultySelected;
  final Function(int) onMajoritySelected;
  const FacutyDropDown({
    super.key,
    required this.containerHeight,
    required this.containerWidth,
    required this.onFacultySelected,
    required this.onMajoritySelected
  });

  @override
  State<FacutyDropDown> createState() => _FacutyDropDownState();
}

class _FacutyDropDownState extends State<FacutyDropDown> {
  bool isExpanded = false;
  int selectedRadio = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
          child: AnimatedContainer(
            width: widget.containerWidth * 1.5,
            height: isExpanded
                ? widget.containerHeight * 1.3
                : widget.containerHeight * 0.3,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(6),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5), // Shadow color
                  blurRadius: 3, // Blur radius
                  offset: Offset(0, 1), // Offset
                ),
              ],
            ),
            duration: Duration(milliseconds: 300),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 8.0,
                      right: 8.0,
                      top: 18,
                    ),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.account_balance_rounded,
                            size: 30,
                            color: Color(0xFF117a5d),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "Select Faculty",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              color: Colors.black54,
                            ),
                          ),
                          SizedBox(
                            width: widget.containerWidth * 0.4,
                          ),
                          Icon(
                            isExpanded
                                ? Icons.keyboard_arrow_up
                                : Icons.keyboard_arrow_down,
                            size: 30,
                            color: Color(0xFF117a5d),
                          ),
                        ]),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  if (isExpanded) ...[
                    buildRadioListTile(
                        'Faculty of Agriculture and Veterinary Medicine', 1),
                    buildRadioListTile(
                        'Faculty of Business and Communication', 2),
                    buildRadioListTile(
                        'Faculty of Engineering and Information Technology', 3),
                    buildRadioListTile('Faculty of Fine Arts', 4),
                    buildRadioListTile(
                        'Faculty of Humanities and Educational Sciences', 5),
                    buildRadioListTile(
                        'Faculty of Law and Political Sciences', 6),
                    buildRadioListTile(
                        'Faculty of Medicine and Health Sciences', 7),
                    buildRadioListTile('Faculty of Science', 8),
                    buildRadioListTile('Faculty of Shari\'ah', 9),
                  ],
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 25,
        ),
        MajorDropDown(
          containerHeight: widget.containerHeight,
          containerWidth: widget.containerWidth,
          selectedRadio: selectedRadio,
          onMajorSelected: (selectedRadio) {
            widget.onMajoritySelected(selectedRadio);
          },
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
          widget.onFacultySelected(selectedRadio);
          print("FacultySelected: $selectedRadio");
        });
      },
    );
  }
}
