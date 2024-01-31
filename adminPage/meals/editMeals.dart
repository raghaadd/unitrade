import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project_1st/generated/l10n.dart';
import 'package:flutter_project_1st/ipaddress.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class editMeals extends StatefulWidget {
  const editMeals(
      {super.key,
      required this.mealtitle,
      required this.price,
      required this.count,
      required this.details,
      required this.image,
      required this.idmeals});
  final String mealtitle;
  final String price;
  final String count;
  final String details;
  final String image;
  final int idmeals;

  @override
  State<editMeals> createState() => _editMealsState();
}

class _editMealsState extends State<editMeals> {
  final TextEditingController _mealnameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _countController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();

  File? image;
  String _downloadURL = '';
  Future pickProfileImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
        print("************imageTemporary:**********");
        print(imageTemporary);
        uploadImage();
        //widget.itemImage = image.path;
      });
      //await profileimage(registerID: registerid, profileimage: imageTemporary);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  void uploadImage() async {
    var random = Random();
    int randomNumber = random.nextInt(100);
    if (image == null) {
      // Handle the case where no image is selected
      return;
    }

    try {
      // Create a reference to the location you want to upload to in Firebase Storage
      firebase_storage.Reference storageRef = firebase_storage
          .FirebaseStorage.instance
          .ref()
          .child('meals') // Change this to your desired storage path
          .child(
              'meals_${randomNumber}_${100}.jpg'); // Adjust the filename or path as needed

      // Upload the file to Firebase Storage
      await storageRef.putFile(image!);

      // Get the download URL of the uploaded file
      String downloadURL = await storageRef.getDownloadURL();
      setState(() {
        _downloadURL = downloadURL;
      });

      // widget.imagepicker(downloadURL);
      //widget.itemImage = downloadURL;

      //await profileimage(registerID: registerid, profileimage: downloadURL);

      // Now, you can use the downloadURL as needed (e.g., store it in your database)

      print('Image uploaded successfully. Download URL: $downloadURL');
    } catch (e) {
      print('Error uploading image: $e');
      // Handle the error appropriately (e.g., show an error message to the user)
    }
  }

  Future<void> editMeals(
      {required String idmeals,
      required String mealtitle,
      required String price,
      required String count,
      required String details,
      required String image}) async {
    final ipAddress = await getLocalIPv4Address();
    final url = Uri.parse('http://$ipAddress:3000/editMeals');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'idmeals': idmeals,
          if (mealtitle.isNotEmpty)
            'mealtitle': mealtitle
          else
            'mealtitle': widget.mealtitle,
          if (price.isNotEmpty) 'price': price else 'price': widget.price,
          if (count.isNotEmpty) 'count': count else 'count': widget.count,
          if (details.isNotEmpty)
            'details': details
          else
            'details': widget.details,
          if (image != null) 'image': image else 'image': widget.image,
        },
      );

      if (response.statusCode == 200) {
        // Data sent successfully
        print('items updated successfully');
        Navigator.pop(context);
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
    return Scaffold(
      backgroundColor: Color(0xFFffffff),
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
                        width: kIsWeb ? 420 : 220,
                        height: kIsWeb ? 270 : 170,
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
                        child: Image.network(
                          widget.image,
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        )
                        //     Image.file(
                        //   File(widget.offerImage),
                        //   fit: BoxFit.cover,
                        //   width: double.infinity,
                        //   height: double.infinity,
                        // )
                        ),
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
                                  color: Colors.white,
                                  child: Wrap(
                                    children: <Widget>[
                                      ListTile(
                                        leading: Icon(Icons.photo_library,
                                            size: 25,
                                            color: const Color(0xFF117a5d)),
                                        title: Text(
                                          S.of(context).pick_from_gallery,
                                          style: TextStyle(
                                            color: Colors.black,
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
                                            color: Colors.black,
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
                  "Meal Name", widget.mealtitle, _mealnameController),
              buildTextField("Price", widget.price, _priceController),
              buildTextField("Count", widget.count, _countController),
              buildTextField("Details", widget.details, _detailsController),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: kIsWeb
                    ? MainAxisAlignment.spaceEvenly
                    : MainAxisAlignment.spaceBetween,
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
                        color: Colors.black,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      String uploadimage;
                      if (image != null) {
                        uploadimage = _downloadURL;
                      } else {
                        uploadimage = widget.image;
                      }
                      await editMeals(
                        idmeals: widget.idmeals.toString(),
                        mealtitle: _mealnameController.text,
                        count: _countController.text,
                        details: _detailsController.text,
                        price: _priceController.text,
                        image: uploadimage,
                      );

                      //Navigator.pop(context);
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) =>
                      //             offerNames(offerCategory: widget.index)));
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

  Widget buildTextField(
      String labelText, String placeHolder, TextEditingController controller) {
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
            color: Colors.black,
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
