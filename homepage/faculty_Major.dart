import 'package:flutter/material.dart';
import 'package:flutter_project_1st/additems/CustomFacultyDropMenu.dart';
import 'package:flutter_project_1st/categorise/slidespage/Slidespage.dart';
import 'package:flutter_project_1st/categorise/slidespage/softcopy/screens/softCopyScreen.dart';
import 'package:flutter_project_1st/settingpage/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class faculty_Major extends StatefulWidget {
  final double containerHeight;
  final double containerWidth;
  final Function(int) onFacultySelected;
  final Function(int) onMajoritySelected;
  final bool flagHard;
  final int registerid;
  const faculty_Major({
    Key? key,
    required this.containerHeight,
    required this.containerWidth,
    required this.onFacultySelected,
    required this.onMajoritySelected,
    required this.flagHard,
    required this.registerid,
  });

  @override
  State<faculty_Major> createState() => _faculty_MajorState();
}

class _faculty_MajorState extends State<faculty_Major> {
  bool isExpanded = false;
  int selectedRadio = 0;
  int _selectedFacultyRadio = 0;
  int _selectedMajorityRadio = 0;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor:
          themeProvider.isDarkMode ? Colors.black12 : Color(0xFFffffff),
      body: Padding(
        padding: const EdgeInsets.only(
            left: 18.0, right: 18.0, top: 60, bottom: 25.0),
        child: Column(
          children: [
            FacutyDropDown(
              containerHeight: widget.containerHeight,
              containerWidth: widget.containerWidth,
              onFacultySelected: (selectedRadio) {
                widget.onFacultySelected(selectedRadio);
                setState(() {
                  _selectedFacultyRadio = selectedRadio;
                });
              },
              onMajoritySelected: (selectedRadio) {
                widget.onMajoritySelected(selectedRadio);
                setState(() {
                  _selectedMajorityRadio = selectedRadio;
                });
              },
            ),
            SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                          print('Cancel button pressed');
                          Navigator.pop(context);
                        },
                        child: Center(
                          child: Text(
                            "Cancel",
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
                          if (widget.flagHard) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Slidespage(
                                          index: 0,
                                          registerid: widget.registerid,
                                          faculty: _selectedFacultyRadio,
                                          major: _selectedMajorityRadio,
                                        )));
                          }else{
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => softcopy(
                                      index: 0,
                                      registerid: widget.registerid,
                                          faculty: _selectedFacultyRadio,
                                          major: _selectedMajorityRadio,)));

                          }
                        },
                        child: Center(
                          child: Text(
                            "Next",
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
            SizedBox(height: 35),
          ],
        ),
      ),
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
