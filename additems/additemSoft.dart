import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_project_1st/additems/Next_Back_btn.dart';
import 'package:flutter_project_1st/generated/l10n.dart';
import 'package:flutter_project_1st/settingpage/theme/theme_provider.dart';
import 'package:provider/provider.dart';

import 'Next_Back_Soft_btn.dart';
import 'additemSoft1.dart';
import 'additemSoft2.dart';
import 'additemSoft3.dart';

class addSoft extends StatefulWidget {
  const addSoft({super.key});

  @override
  State<addSoft> createState() => _addSoftState();
}

class _addSoftState extends State<addSoft> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _itemnameController = TextEditingController();
  final TextEditingController _DescriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final selectRadioCategory = 0;

  late double containerWidth;
  late double containerHeight;
  int CurrentStep = 0;

  int _selectedCategoryRadio = 0;
  int freecheckBox = 0;
  int _selectedFacultyRadio = 0;
  int _selectedMajorityRadio = 0;
  String _phoneNumber = " ";
  File? imagePicker;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    containerWidth = MediaQuery.of(context).size.width * 0.73;
    containerHeight = MediaQuery.of(context).size.height * 0.26;
    return Scaffold(
      backgroundColor:
          themeProvider.isDarkMode ? Colors.black12 : Color(0xFFffffff),
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Theme(
          data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
            primary: Color(0xFF117a5d).withOpacity(0.85),
          )),
          child: Stepper(
            type: StepperType.horizontal,
            steps: getSteps(),
            currentStep: CurrentStep,
            onStepContinue: () {
              print("*******continue");
              final isLastStep = CurrentStep == getSteps().length - 1;
              FocusScope.of(context).unfocus();
              if (isLastStep) {
                print("completed");
              } else {
                setState(() {
                  print('Description:');
                  print(_DescriptionController.text);
                  CurrentStep += 1;
                });
              }
            },
            onStepCancel: CurrentStep == 0
                ? null
                : () => setState(() {
                      CurrentStep -= 1;
                    }),
            controlsBuilder: (context, details) {
              final isLastStep = CurrentStep == getSteps().length - 1;
              // _priceController.text = '0';
              return Next_Back__soft_btn(
                CurrentStep: CurrentStep,
                isLastStep: isLastStep,
                details: details,
                itemnameController: _itemnameController.text,
                DescriptionController: _DescriptionController.text,
                selectRadioCategory: _selectedCategoryRadio,
                freeCheckBox: freecheckBox,
                phoneNumber: _phoneNumber,
                selectRadioFaculty: _selectedFacultyRadio,
                selectRadioMajority: _selectedMajorityRadio,
                selectedImage: imagePicker,
                priceController: _priceController.text,
              );
            },
          ),
        ),
      ),
    );
  }

  List<Step> getSteps() => [
        Step(
          state: CurrentStep > 0 ? StepState.complete : StepState.indexed,
          isActive: CurrentStep >= 0,
          title: Text(
            S.of(context).Details,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          content: AddItemSoft1(
            containerWidth: containerWidth,
            containerHeight: containerHeight,
            formKey: _formKey,
            itemnameController: _itemnameController,
            DescriptionController: _DescriptionController,
            pdfFile: (imagepicker) {
              setState(() {
                imagePicker = imagepicker;
              });
            },
          ),
        ),
        Step(
            state: CurrentStep > 1 ? StepState.complete : StepState.indexed,
            isActive: CurrentStep >= 1,
            title: Text(
              S.of(context).Select,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
            content: addItemSoft2(
              containerHeight: containerHeight,
              containerWidth: containerWidth,
              priceController: _priceController,
              onCategorySelected: (selectedRadio) {
                print('Selected Category Main: $selectedRadio');
                setState(() {
                  _selectedCategoryRadio = selectedRadio;
                });
                print('_selectedCategoryRadio Main: $_selectedCategoryRadio');
              },
              freecheckBox: (selectedRadio) {
                setState(() {
                  freecheckBox = selectedRadio;
                });
              },
              phoneNumber: (phoneNumber) {
                setState(() {
                  _phoneNumber = phoneNumber;
                });
              },
            )),
        Step(
          isActive: CurrentStep >= 2,
          title: Text(
            S.of(context).Complete,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          content: addItemSoft3(
              containerHeight: containerHeight,
              containerWidth: containerWidth,
              onFacultySelected: (selectedRadio) {
                setState(() {
                  _selectedFacultyRadio = selectedRadio;
                });
              },
              onMajoritySelected: (selectedRadio) {
                setState(() {
                  _selectedMajorityRadio = selectedRadio;
                });
              }),
        ),
      ];
}
