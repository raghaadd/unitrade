import 'dart:io';
import 'dart:math';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project_1st/additems/CustomItemname_tx.dart';
import 'package:flutter_project_1st/additems/CustomPrice_tx.dart';
import 'package:flutter_project_1st/generated/l10n.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter_project_1st/ipaddress.dart';
import 'package:flutter_project_1st/offers/offerAppBar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:http/http.dart' as http;

class addNewOffer extends StatefulWidget {
  const addNewOffer({super.key, required this.index});
  final int index;

  @override
  State<addNewOffer> createState() => _addNewOfferState();
}

class _addNewOfferState extends State<addNewOffer> {
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
    if (image == null) {
      // Handle the case where no image is selected
      return;
    }

    try {
      // Create a reference to the location you want to upload to in Firebase Storage
      firebase_storage.Reference storageRef = firebase_storage
          .FirebaseStorage.instance
          .ref()
          .child('profile_images') // Change this to your desired storage path
          .child(
              'item_${Random()}.jpg'); // Adjust the filename or path as needed

      // Upload the file to Firebase Storage
      await storageRef.putFile(image!);

      // Get the download URL of the uploaded file
      String downloadURL = await storageRef.getDownloadURL();
      _downloadURL = downloadURL;
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

  Future<void> AddOfferDetailsinfo(
      {required String idofferNames,
      required String offerdetailsName,
      required String price,
      required String image}) async {
    final ipAddress = await getLocalIPv4Address();
    final url = Uri.parse('http://$ipAddress:3000/addofferDetails');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'idofferNames': idofferNames,
          'offerdetailsName': offerdetailsName,
          'price': price,
          'image': image,
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
    final TextEditingController _itemnameController = TextEditingController();
    final TextEditingController _priceController = TextEditingController();
    double containerWidth = MediaQuery.of(context).size.width * 0.73;
    double containerHeight = MediaQuery.of(context).size.height * 0.22;
    final FocusNode _focusNode = FocusNode();

    @override
    void dispose() {
      _focusNode.dispose();
      super.dispose();
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: appBarOffers(),
      ),
      backgroundColor: Color(0xFFffffff),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 20,
            ),
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
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Container(
                child: Column(
                  children: <Widget>[
                    ItemNameTextField(
                      itemName: "Item Name",
                      controller: _itemnameController,
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    PriceTextField(
                      controller: _priceController,
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
                            // String uploadimage;
                            // if (image != null) {
                            //   uploadimage = _downloadURL;
                            // } else {
                            //    uploadimage = widget.offerImage;
                            // }
                            await AddOfferDetailsinfo(
                              idofferNames: widget.index.toString(),
                              offerdetailsName: _itemnameController.text,
                              price: _priceController.text,
                              image: _downloadURL,
                            );
                            Navigator.pop(context);
                            Navigator.pop(context);
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) =>
                            //             offerNames(offerCategory: widget.index)));
                          },
                          child: Text(
                            S.of(context).Save,
                            style: TextStyle(
                                fontSize: 20,
                                letterSpacing: 2,
                                color: Colors.white),
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
          ],
        ),
      ),
    );
  }
}
