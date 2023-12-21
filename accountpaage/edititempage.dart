import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project_1st/generated/l10n.dart';
import 'package:flutter_project_1st/homepage/hidden_drawer.dart';
import 'package:flutter_project_1st/ipaddress.dart';
import 'package:flutter_project_1st/settingpage/theme/theme_provider.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class editPost extends StatefulWidget {
  editPost(
      {super.key,
      required this.itemTitle,
      required this.itemPrice,
      required this.itemStatus,
      required this.itemDescription,
      required this.itemId,
      required this.itemImage});
  final String itemTitle;
  final String itemPrice;
  final String itemStatus;
  final String itemDescription;
  final int itemId;
  String itemImage;

  @override
  State<editPost> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<editPost> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController statusController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  File? image;
  Future pickProfileImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
        print("************imageTemporary:**********");
        print(imageTemporary);
        widget.itemImage = image.path;
      });
      //await profileimage(registerID: registerid, profileimage: imageTemporary);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future<void> edititemsinfo(
      {required String itemID,
      required String title,
      required String price,
      required String status,
      required String description,
      required File image}) async {
    final ipAddress = await getLocalIPv4Address();
    final url = Uri.parse('http://$ipAddress:3000/edititemInfo');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'iditem': itemID,
          if (title.isNotEmpty) 'title': title else 'title': widget.itemTitle,
          if (price.isNotEmpty) 'price': price else 'price': widget.itemPrice,
          if (status.isNotEmpty)
            'status': status
          else
            'status': widget.itemStatus,
          if (description.isNotEmpty)
            'description': description
          else
            'description': widget.itemDescription,
          if (image != null)
            'image': image?.path.toString()
          else
            'image': widget.itemImage,
        },
      );

      if (response.statusCode == 200) {
        // Data sent successfully
        print('items updated successfully');
        setState(() {});
      } else {
        print('HTTP error: ${response.statusCode}');
      }
    } catch (error) {
      // Handle network or other errors
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor:
          themeProvider.isDarkMode ? Colors.black54 : Color(0xFFffffff),
      body: Container(
        padding: EdgeInsets.only(left: 15, top: 30, right: 15),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Center(
                child: Stack(
                  children: [
                    Container(
                        width: 220,
                        height: 170,
                        decoration: BoxDecoration(
                          border: Border.all(width: 4, color: Colors.white),
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.1))
                          ],
                          shape: BoxShape.rectangle,
                        ),
                        child: Image.file(
                          File(widget.itemImage),
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        )),
                    Positioned(
                      bottom: -12,
                      right: -12,
                      child: SizedBox(
                        height: 46,
                        width: 46,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                              side: const BorderSide(color: Colors.white),
                            ),
                            backgroundColor: const Color(0xFFF5F6F9),
                          ),
                          onPressed: () {
                            print("inside vhange image");
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
                                        leading: Icon(Icons.photo_library,
                                            size: 25,
                                            color: const Color(0xFF117a5d)),
                                        title: Text(
                                          S.of(context).pick_from_gallery,
                                          style: TextStyle(
                                            color: themeProvider.isDarkMode
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                        ),
                                        onTap: () {
                                          // Handle "Pick from Gallery" option
                                          //Navigator.pop(context);
                                          print("Pick from Gallery");
                                          pickProfileImage(ImageSource.gallery);
                                          Navigator.pop(context);
                                        },
                                      ),
                                      ListTile(
                                        leading: Icon(Icons.camera_alt,
                                            size: 25,
                                            color: const Color(0xFF117a5d)),
                                        title: Text(
                                          S.of(context).take_photo,
                                          style: TextStyle(
                                            color: themeProvider.isDarkMode
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                        ),
                                        onTap: () {
                                          // Handle "Take a Photo" option
                                          //Navigator.pop(context);
                                          print("Take a Photo");
                                          pickProfileImage(ImageSource.camera);
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          child: Image.asset("assets/camera.png"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              buildTextField(
                  S.of(context).title, widget.itemTitle, titleController, themeProvider),
              buildTextField(
                  S.of(context).price, widget.itemPrice, priceController, themeProvider),
              buildTextField(
                  S.of(context).Status, widget.itemStatus, statusController, themeProvider),
              buildTextField(S.of(context).Description, widget.itemDescription,
                  descriptionController, themeProvider),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      S.of(context).Cancel,
                      style: TextStyle(
                        fontSize: 20,
                        letterSpacing: 2,
                        color: themeProvider.isDarkMode
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      File uploadimage;
                      if (image != null) {
                        uploadimage = File(image!.path);
                      } else {
                        uploadimage = File(widget.itemImage);
                      }
                      await edititemsinfo(
                        itemID: widget.itemId.toString(),
                        title: titleController.text,
                        price: priceController.text,
                        status: statusController.text,
                        description: descriptionController.text,
                        image: File(uploadimage.path),
                      );
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HiddenDrawer(page: 3)));
                    },
                    child: Text(
                      S.of(context).Save,
                      style: TextStyle(
                          fontSize: 20, letterSpacing: 2, color: Colors.white),
                    ),
                    style: OutlinedButton.styleFrom(
                        backgroundColor: Color(0xFF117a5d),
                        padding: EdgeInsets.symmetric(horizontal: 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String labelText, String placeHolder,
      TextEditingController controller, themeProvider) {
    return Padding(
      padding: EdgeInsets.only(bottom: 30),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(bottom: 5),
          labelText: labelText,
          labelStyle: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: themeProvider.isDarkMode ? Colors.white : Colors.black,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: placeHolder,
          hintStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Colors.black45), // Set your desired color
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
