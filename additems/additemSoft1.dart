import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project_1st/additems/CustomDescription_tx.dart';
import 'package:flutter_project_1st/additems/CustomItemname_tx.dart';
import 'package:flutter_project_1st/additems/CustomPrice_tx.dart';
import 'package:flutter_project_1st/generated/l10n.dart';
import 'package:flutter_project_1st/settingpage/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class AddItemSoft1 extends StatefulWidget {
  const AddItemSoft1(
      {super.key,
      required this.containerWidth,
      required this.containerHeight,
      required GlobalKey<FormState> formKey,
      required TextEditingController itemnameController,
      required TextEditingController DescriptionController,
      required this.pdfFile})
      : _formKey = formKey,
        _itemnameController = itemnameController,
        _DescriptionController = DescriptionController;

  final double containerWidth;
  final double containerHeight;
  final GlobalKey<FormState> _formKey;
  final TextEditingController _itemnameController;
  final TextEditingController _DescriptionController;
  final Function(File) pdfFile;

  @override
  State<AddItemSoft1> createState() => _AddItemSoft1State();
}

class _AddItemSoft1State extends State<AddItemSoft1> {
  File? pdfFile;

  Future pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );
      print("****************result:");
      print(result);

      if (result != null) {
        pdfFile = File(result.files.single.path!);
        setState(() {
          // Handle the selected PDF file
          widget.pdfFile(pdfFile!);
        });
      } else {
        // User canceled the file picking
        print("User canceled file picking");
      }
    } catch (e) {
      print('Error picking file: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      color: themeProvider.isDarkMode
                          ? Colors.black87
                          : Colors.white,
                      child: Wrap(
                        children: <Widget>[
                          ListTile(
                            leading: Icon(Icons.picture_as_pdf,
                                size: 25, color: const Color(0xFF117a5d)),
                            title: Text(
                              S.of(context).pick_pdf,
                              style: TextStyle(
                                color: themeProvider.isDarkMode
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                            onTap: () async {
                              // Handle "Pick PDF File" option
                              Navigator.pop(context);
                              print("Pick PDF File");
                              await pickFile();
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              child: DottedBorder(
                dashPattern: [20, 12, 12, 20],
                borderType: BorderType.Rect,
                radius: Radius.circular(10),
                padding: EdgeInsets.all(6),
                strokeWidth: 1,
                color: Colors.grey.shade500,
                child: Container(
                  padding: EdgeInsets.all(20),
                  width: widget.containerWidth * 1.15,
                  height: widget.containerHeight,
                  child: Stack(
                    children: [
                      if (pdfFile != null)
                        Image.asset(
                          'assets/pdf.png',
                          width: widget.containerWidth * 1.15,
                          height: widget.containerHeight,
                          fit: BoxFit.cover,
                        )
                      else
                        Column(
                          children: [
                            Icon(
                              Icons.file_copy_rounded,
                              size: 100,
                              color: const Color(0xFF117a5d).withOpacity(0.7),
                            ),
                            Text(
                              S.of(context).add_file,
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                                color: themeProvider.isDarkMode
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                            Text(
                              S.of(context).remove_image,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey.shade600,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      // Close icon
                      if (pdfFile != null)
                        Positioned(
                          top: -8,
                          right: 0,
                          child: GestureDetector(
                            onTap: () {
                              // Set the image to null when close icon is pressed
                              setState(() {
                                pdfFile = null;
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.black.withOpacity(0.5),
                              ),
                              child: Icon(
                                Icons.close_rounded,
                                size: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Form(
                key: widget._formKey,
                child: Container(
                  child: Column(
                    children: <Widget>[
                      ItemNameTextField(
                        itemName: S.of(context).file_name,
                        controller: widget._itemnameController,
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      DescriptionTextField(
                        controller: widget._DescriptionController,
                      ),
                      SizedBox(
                        height: 35,
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
