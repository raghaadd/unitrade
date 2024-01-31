import 'package:flutter/material.dart';
import 'package:flutter_project_1st/generated/l10n.dart';
import 'package:flutter_project_1st/ipaddress.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart' show kIsWeb;

class editMarket extends StatefulWidget {
  const editMarket({
    super.key,
    required this.idofferNames,
    required this.offerDetails,
    required this.discount,
    required this.phoneNumber,
    required this.location,
    required this.details,
  });
  final String idofferNames;
  final String offerDetails;
  final String discount;
  final String phoneNumber;
  final String location;
  final String details;

  @override
  State<editMarket> createState() => _editMarketState();
}

class _editMarketState extends State<editMarket> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController discountController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController detailsController = TextEditingController();

  Future<void> editMarketinfo(
      {required String idofferNames,
      required String offerDetails,
      required String discount,
      required String phoneNumber,
      required String location,
      required String details}) async {
    final ipAddress = await getLocalIPv4Address();
    final url = Uri.parse('http://$ipAddress:3000/editMraketDetails');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'idofferNames': idofferNames,
          if (offerDetails.isNotEmpty)
            'offerDetails': offerDetails
          else
            'offerDetails': widget.offerDetails,
          if (discount.isNotEmpty)
            'discount': discount
          else
            'discount': widget.discount,
          if (phoneNumber.isNotEmpty)
            'phoneNumber': phoneNumber
          else
            'phoneNumber': widget.phoneNumber,
          if (location.isNotEmpty)
            'location': location
          else
            'location': widget.location,
          if (details.isNotEmpty)
            'details': details
          else
            'details': widget.details,
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
              SizedBox(
                height: 30,
              ),
              buildTextField(
                  "Offer Name", widget.offerDetails, titleController),
              buildTextField("Discount", widget.discount, discountController),
              buildTextField(
                  "Phone Number", widget.phoneNumber, phoneNumberController),
              buildTextField("Location", widget.location, locationController),
              buildTextField("Details", widget.details, detailsController),
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
                      await editMarketinfo(
                          idofferNames: widget.idofferNames,
                          offerDetails: titleController.text,
                          details: detailsController.text,
                          discount: discountController.text,
                          location: locationController.text,
                          phoneNumber: phoneNumberController.text);
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
