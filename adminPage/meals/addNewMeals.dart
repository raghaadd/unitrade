import 'dart:io';
import 'dart:math';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project_1st/generated/l10n.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_project_1st/ipaddress.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';



class addNewMeals extends StatefulWidget {
  const addNewMeals({super.key});

  @override
  State<addNewMeals> createState() => _addNewMealsState();
}

class _addNewMealsState extends State<addNewMeals> {
  final TextEditingController _mealnameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _countController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();

  File? image;
  String _downloadURL = '';
  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
        print("************imageTemporary:**********");
        print(imageTemporary);
        //widget.imagepicker(imageTemporary);
        uploadImage();
      });
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

  Future<void> AddNewMeals(
      {required String mealtitle,
      required String price,
      required String count,
      required String details,
      required String image}) async {
    final ipAddress = await getLocalIPv4Address();
    final url = Uri.parse('http://$ipAddress:3000/addNewMeals');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'mealtitle': mealtitle,
          'price': price,
          'count': count,
          'details': details,
          'image': image
        },
      );

      if (response.statusCode == 200) {
        // Data sent successfully
        print('items updated successfully');
        Navigator.pop(context);
        // Navigator.push(
        //     context, MaterialPageRoute(builder: (context) => mealsMain()));
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
    double containerWidth = MediaQuery.of(context).size.width * 0.73;
    double containerHeight = MediaQuery.of(context).size.height * 0.22;
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
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        color: Colors.white,
                        child: Wrap(
                          children: <Widget>[
                            ListTile(
                              leading: Icon(Icons.photo_library,
                                  size: 25, color: const Color(0xFF117a5d)),
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
                                pickImage(ImageSource.gallery);
                              },
                            ),
                            ListTile(
                              leading: Icon(Icons.camera_alt,
                                  size: 25, color: const Color(0xFF117a5d)),
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
                                pickImage(ImageSource.camera);
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
                    width: containerWidth * 1.15,
                    height: containerHeight,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Image or placeholder
                        if (image != null)
                          Image.file(
                            image!,
                            width: containerWidth * 1.15,
                            height: containerHeight,
                            fit: BoxFit.cover,
                          )
                        else
                          Column(
                            children: [
                              Icon(
                                Icons.image_rounded,
                                size: 60,
                                color: const Color(0xFF117a5d).withOpacity(0.7),
                              ),
                              Text(
                                S.of(context).add_image,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        // Close icon
                        if (image != null)
                          Positioned(
                            top: -8,
                            right: 0,
                            child: GestureDetector(
                              onTap: () {
                                // Set the image to null when close icon is pressed
                                setState(() {
                                  image = null;
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
                height: 18,
              ),
              TextField(
                controller: _mealnameController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: "Meal Name",
                  hintStyle: TextStyle(
                    color: Colors.black,
                  ),
                ),
                style: TextStyle(
                  color: Colors.black, // Set your desired text color here
                ),
              ),
              SizedBox(
                height: 18,
              ),
              TextField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: "Price",
                  hintStyle: TextStyle(
                    color: Colors.black,
                  ),
                ),
                style: TextStyle(
                  color: Colors.black, // Set your desired text color here
                ),
              ),
              SizedBox(
                height: 18,
              ),
              TextField(
                controller: _countController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: "Count",
                  hintStyle: TextStyle(
                    color: Colors.black,
                  ),
                ),
                style: TextStyle(
                  color: Colors.black, // Set your desired text color here
                ),
              ),
              SizedBox(
                height: 18,
              ),
              TextField(
                controller: _detailsController,
                maxLines: 3,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: S.of(context).Details,
                  hintStyle: TextStyle(
                    color: Colors.black,
                  ),
                ),
                style: TextStyle(
                  color: Colors.black, // Set your desired text color here
                ),
              ),
              SizedBox(
                height: 18,
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
                      AddNewMeals(
                        mealtitle: _mealnameController.text,
                        price: _priceController.text,
                        count: _countController.text,
                        details: _detailsController.text,
                        image: _downloadURL,
                      );
                      //Navigator.pop(context);
                      // Navigator.pop(context);
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
}
