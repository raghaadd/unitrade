

import 'package:flutter/material.dart';
import 'package:flutter_project_1st/Notificationpage/appBarNotification.dart';
import 'package:flutter_project_1st/generated/l10n.dart';
import 'package:flutter_project_1st/ipaddress.dart';
import 'package:flutter_project_1st/payment/defaultButton.dart';
import 'package:flutter_project_1st/payment/payment.dart';
import 'package:flutter_project_1st/registerID.dart';
import 'package:flutter_project_1st/settingpage/theme/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;


// ignore: must_be_immutable
class CheckoutPage extends StatefulWidget {
  CheckoutPage(
      {Key? key,
      required this.image,
      required this.mealName,
      required this.count,
      required this.idmeal,
      required this.price})
      : super(key: key);
  final String image;
  final String mealName;
  int count;
  final int idmeal;
  final int price;

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  int totalPrice = 0;
  TimeOfDay selectedTime = TimeOfDay.now();
  TextEditingController notesController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  String registerID = "";

  @override
  void initState() {
    totalPrice = calcualtePrice(widget.count, widget.price);
    super.initState();
  }

  calcualtePrice(int count, int price) {
    int totalPrice = count * price;
    return totalPrice;
  }

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserData>(context, listen: false);
    registerID = userData.registerID;
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: themeProvider.isDarkMode
          ? Color.fromARGB(255, 37, 37, 37).withOpacity(0.3)
          : Color(0xFFffffff),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: appBarNotification(
          title: S.of(context).order_now,
          fromUserprofiel: false,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 2,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 140,
                        height: 150,
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          child: Image.network(
                                  widget.image,
                                  fit: BoxFit.cover,
                                )
                              // : Image.file(
                              //     File(widget.image),
                              //     fit: BoxFit.cover,
                              //   ),
                        ),
                      ),
                      Column(
                        children: [
                          Text(
                            widget.mealName,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            widget.price.toString() + "₪",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            S.of(context).Total + totalPrice.toString() + "₪",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    //color: Color(0xFF117a5d),
                                  ),
                                  padding: const EdgeInsets.all(1),
                                  child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        widget.count++;
                                        totalPrice = calcualtePrice(
                                            widget.count, widget.price);
                                      });
                                    },
                                    icon: Icon(
                                      Icons.add,
                                      size: 20,
                                    ),
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: 4),
                            Text(
                              widget.count.toString(),
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(width: 4),
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                //color: Color(0xFF117a5d),
                              ),
                              padding: const EdgeInsets.all(1),
                              child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (widget.count > 1) {
                                      widget.count--;
                                      totalPrice = calcualtePrice(
                                          widget.count, widget.price);
                                    }
                                  });
                                },
                                icon: Icon(
                                  Icons.remove,
                                  size: 20,
                                ),
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        S.of(context).Delivery_Time,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: themeProvider.isDarkMode
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white10,
                          // padding: EdgeInsets.all(20),
                          //fixedSize: Size(170, 70)
                        ),
                        onPressed: () async {
                          TimeOfDay? pickedTime = await showTimePicker(
                            context: context,
                            initialTime: selectedTime,
                          );
                          if (pickedTime != null) {
                            setState(() {
                              selectedTime = pickedTime;
                            });
                          }
                        },
                        child: Text(
                          '${selectedTime.format(context)}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: themeProvider.isDarkMode
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S.of(context).Delivery_Address,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: themeProvider.isDarkMode
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: addressController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      hintText: S.of(context).Enter_delivery_address,
                      hintStyle: TextStyle(
                        color: themeProvider.isDarkMode
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                    style: TextStyle(
                      color: themeProvider.isDarkMode
                          ? Colors.white
                          : Colors.black, // Set your desired text color here
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S.of(context).Phone_Number,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: themeProvider.isDarkMode
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      hintText: S.of(context).Enter_phone_number,
                      hintStyle: TextStyle(
                        color: themeProvider.isDarkMode
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                    style: TextStyle(
                      color: themeProvider.isDarkMode
                          ? Colors.white
                          : Colors.black, // Set your desired text color here
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S.of(context).Additional_Notes,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: themeProvider.isDarkMode
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: notesController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      hintText: S.of(context).Enter_special_instructions,
                      hintStyle: TextStyle(
                        color: themeProvider.isDarkMode
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                    style: TextStyle(
                      color: themeProvider.isDarkMode
                          ? Colors.white
                          : Colors.black, // Set your desired text color here
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
              child: DefaultButton(
                btnText: S.of(context).Next,
                onPressed: () async {
                  print(widget.idmeal);
                  print(addressController.text);
                  print(notesController.text);
                  print(phoneController.text);
                  print(totalPrice);
                  print(widget.count);
                  print(selectedTime.format(context));
                  await mealspayment(
                      idmeals: widget.idmeal.toString(),
                      deliveryAddress: addressController.text.toString(),
                      notes: notesController.text.toString(),
                      phoneNumber: phoneController.text.toString(),
                      price: totalPrice.toString(),
                      mealscount: widget.count.toString(),
                      deliveryTime: selectedTime.format(context).toString());
                },
                widthFactor: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> mealspayment({
    required String idmeals,
    required String price,
    required String mealscount,
    required String deliveryTime,
    required String deliveryAddress,
    required String phoneNumber,
    required String notes,
  }) async {
    final ipAddress = await getLocalIPv4Address();
    final url = Uri.parse('http://$ipAddress:3000/mealspayment');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'idmeals': idmeals,
          'price': price,
          'mealscount': mealscount,
          'deliveryTime': deliveryTime,
          'deliveryAddress': deliveryAddress,
          'phoneNumber': phoneNumber,
          'notes': notes,
        },
      );
      if (response.statusCode == 200) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => PaymentScreen(
                RegisterID: registerID,
                itemId: widget.idmeal.toString(),
                itemname: widget.mealName,
                price: totalPrice.toString(),
                ismeal: "1"),
          ),
        );
        print('paymeals successful');
      } else {
        print('HTTP error: ${response.statusCode}');
      }
    } catch (error) {
      // Handle network or other errors
      print('Error: $error');
    }
  }
}
