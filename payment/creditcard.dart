import 'package:flutter/material.dart';
import 'package:flutter_project_1st/Notificationpage/appBarNotification.dart';
import 'package:flutter_project_1st/generated/l10n.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:flutter_credit_card/src/credit_card_form.dart';
import 'package:flutter_credit_card/src/models/credit_card_model.dart';
import 'package:flutter_project_1st/ipaddress.dart';
import 'package:flutter_project_1st/payment/success.dart';
import 'package:flutter_project_1st/registerID.dart';
import 'package:provider/provider.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:http/http.dart' as http;

class CreditCardScreen extends StatefulWidget {
  const CreditCardScreen(
      {Key? key, required this.itemId, required this.registerID})
      : super(key: key);
  final String itemId;
  final String registerID;

  @override
  State<CreditCardScreen> createState() => _CreditCardScreenState();
}

class _CreditCardScreenState extends State<CreditCardScreen> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  int selectedIconIndex = -1;
  bool isCvvFocused = false;
  Color colorIcon = Colors.black54;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String registerID = '';

  @override
  void initState() {
    super.initState();
    initializeData();
  }

  Future<void> initializeData() async {
    try {
      final userData = Provider.of<UserData>(context, listen: false);
      registerID = userData.registerID;

      if (registerID != null) {
        print("inside initializeData");
        print(registerID);
      } else {
        // Handle the case where registerID is null
        print('RegisterID is null.');
      }
    } catch (error) {
      // Handle errors
      print('Error initializing data: $error');
    }
  }

  Future<void> addSeeNotification({
    required String iditem,
    required int seeNotif,
    required String itemReqester,
  }) async {
    final ipAddress = await getLocalIPv4Address();
    final url = Uri.parse('http://$ipAddress:3000/addSeeNotif');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'iditem': iditem,
          'seeNotification': seeNotif.toString(),
          'itemRequester': itemReqester
        },
      );

      if (response.statusCode == 200) {
        // Data sent successfully
        print('Reserved successfully');
      } else if (response.statusCode == 400) {
        print("400 error");
      } else {
        print('HTTP error: ${response.statusCode}');
      }
    } catch (error) {
      // Handle network or other errors
      print('Error: $error');
    }
  }

  Future<void> UpdateSaleCounter({
    required String registerID,
  }) async {
    final ipAddress = await getLocalIPv4Address();
    final url = Uri.parse('http://$ipAddress:3000/updateSale');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {'registerID': registerID},
      );

      if (response.statusCode == 200) {
        // Data sent successfully
        print('SaleCounter updated successfully');
      } else if (response.statusCode == 400) {
        print("400 error");
      } else {
        print('HTTP error: ${response.statusCode}');
      }
    } catch (error) {
      // Handle network or other errors
      print('Error: $error');
    }
  }

  Future<void> addPayment({
    required String sellerId,
    required String purchaserId,
    required String pay,
  }) async {
    final ipAddress = await getLocalIPv4Address();
    final url = Uri.parse('http://$ipAddress:3000/addPayment');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'sellerId': sellerId,
          'purchaserId': purchaserId,
          'payDone': pay
        },
      );

      if (response.statusCode == 200) {
        print('HTTP successful: ${response.statusCode}');
      }
    } catch (error) {
      // Handle network or other errors
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: appBarNotification(
          title: S.of(context).Credit_card,
          fromUserprofiel: false,
        ),
      ),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          children: [
            CreditCardWidget(
              customCardTypeIcons: [
                CustomCardTypeIcon(
                  cardType: CardType.unionpay,
                  cardImage: Image.asset(
                    "assets/chip.png",
                    width: 30,
                    height: 30,
                  ),
                ),
                CustomCardTypeIcon(
                  cardType: CardType.otherBrand,
                  cardImage: Image.asset(
                    "assets/mastercard.png",
                    width: 40,
                    height: 40,
                  ),
                )
              ],
              cardNumber: cardNumber,
              expiryDate: expiryDate,
              cardHolderName: cardHolderName,
              cvvCode: cvvCode,
              showBackView: isCvvFocused,
              obscureCardNumber: true,
              obscureCardCvv: true,
              cardBgColor: Colors.black87,
              onCreditCardWidgetChange: (CreditCardBrand cardBrand) {
                // Handle changes in the credit card widget (if needed)
              },
            ),
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  CreditCardForm(
                    cardNumber: cardNumber,
                    expiryDate: expiryDate,
                    cardHolderName: cardHolderName,
                    cvvCode: cvvCode,
                    onCreditCardModelChange: onCreditCardModelChange,
                    formKey: formKey,
                  ),
                  SizedBox(height: 40),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          backgroundColor: Color(0xFF117a5d).withOpacity(0.7)),
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          print('valid');
                          await addSeeNotification(
                              seeNotif: 1,
                              iditem: widget.itemId.toString(),
                              itemReqester: registerID);
                          await UpdateSaleCounter(
                              registerID: widget.registerID);
                          await addPayment(
                              sellerId: widget.registerID,
                              purchaserId: registerID,
                              pay: "1");
                          // show();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SuccessScreen(),
                              ));
                        } else {
                          print('invalid');
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.all(8.0),
                        child: Text(
                          S.of(context).validate,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }

  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }

  // void show() {
  //   showDialog(
  //     context: context,
  //     barrierDismissible: true,
  //     builder: (context) {
  //       return StatefulBuilder(
  //           builder: (BuildContext context, StateSetter setState) {
  //         return Dialog(
  //           child: Stack(
  //             children: [
  //               Container(
  //                 width: 340,
  //                 height: 450,
  //                 decoration: BoxDecoration(
  //                   color: Colors.white,
  //                   borderRadius: BorderRadius.circular(6),
  //                   boxShadow: [
  //                     BoxShadow(
  //                       color: Colors.grey.withOpacity(0.5),
  //                       spreadRadius: 2,
  //                       offset: Offset(0, 3),
  //                     ),
  //                   ],
  //                 ),
  //                 padding: EdgeInsets.all(16),
  //                 child: Column(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   crossAxisAlignment: CrossAxisAlignment.center,
  //                   children: [],
  //                 ),
  //               ),
  //               Positioned(
  //                 top: 8,
  //                 right: 8,
  //                 child: Container(
  //                   //padding: EdgeInsets.all(0.5),
  //                   decoration: BoxDecoration(
  //                     shape: BoxShape.circle,
  //                     color: Colors.grey.shade200,
  //                   ),
  //                   child: IconButton(
  //                     icon: Icon(
  //                       Icons.close,
  //                       color: Colors.black,
  //                       size: 30,
  //                     ),
  //                     onPressed: () {
  //                       Navigator.of(context).pop(); // Close the dialog.
  //                     },
  //                   ),
  //                 ),
  //               ),
  //               Positioned(
  //                   top: 45,
  //                   left: 20,
  //                   child: Text(
  //                     "Give Review",
  //                     style: TextStyle(
  //                         color: Colors.black,
  //                         fontWeight: FontWeight.bold,
  //                         fontSize: 24),
  //                   )),
  //               Positioned(
  //                   top: 75,
  //                   left: 20,
  //                   child: Text(
  //                     "Give your review based on real-life experiences",
  //                     style: TextStyle(color: Colors.black, fontSize: 14),
  //                   )),
  //               Positioned(
  //                 top: 120,
  //                 left: 20,
  //                 child: Row(
  //                   children: [
  //                     buildIconButton(
  //                         Icons.sentiment_very_dissatisfied, 0, setState),
  //                     buildIconButton(
  //                         Icons.sentiment_dissatisfied, 1, setState),
  //                     buildIconButton(Icons.sentiment_neutral, 2, setState),
  //                     buildIconButton(Icons.sentiment_satisfied, 3, setState),
  //                     buildIconButton(
  //                         Icons.sentiment_very_satisfied, 4, setState),
  //                   ],
  //                 ),
  //               ),
  //               Positioned(
  //                   top: 210,
  //                   left: 20,
  //                   child: Text(
  //                     "Do you have any other comments?",
  //                     style: TextStyle(
  //                         color: Colors.black,
  //                         fontSize: 16,
  //                         fontWeight: FontWeight.w700),
  //                   )),
  //               Positioned(
  //                 top: 240,
  //                 left: 20,
  //                 child: Container(
  //                   width: 300, // Adjusted width based on your design
  //                   decoration: BoxDecoration(
  //                     border: Border.all(
  //                         color:
  //                             Color(0xFF117a5d)), // Set border color to green
  //                     borderRadius: BorderRadius.circular(8),
  //                   ),
  //                   child: TextField(
  //                     maxLines: 5, // Set the number of lines you want
  //                     decoration: InputDecoration(
  //                       contentPadding: EdgeInsets.all(8),
  //                       hintText: "Type your comment here...",
  //                       border: InputBorder.none,
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //               Positioned(
  //                   top: 390,
  //                   left: 20,
  //                   child: Row(
  //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                     children: [
  //                       Container(
  //                         width: 140,
  //                         decoration: BoxDecoration(
  //                           color:
  //                               Color(0xFF117a5d), // Set green background color
  //                           borderRadius: BorderRadius.circular(8),
  //                           boxShadow: [
  //                             BoxShadow(
  //                               color: Color(0xFF117a5d).withOpacity(0.5),
  //                               spreadRadius: 2,
  //                               blurRadius: 4,
  //                               offset: Offset(0, 2),
  //                             ),
  //                           ],
  //                         ),
  //                         child: ElevatedButton(
  //                           onPressed: () {
  //                             // Handle "Send" button action.
  //                           },
  //                           style: ElevatedButton.styleFrom(
  //                             primary: Colors
  //                                 .transparent, // Set transparent background
  //                             elevation: 0, // Remove elevation
  //                             shape: RoundedRectangleBorder(
  //                               borderRadius: BorderRadius.circular(8),
  //                             ),
  //                           ),
  //                           child: Text(
  //                             "Send",
  //                             style: TextStyle(
  //                                 color: Colors.white,
  //                                 fontWeight: FontWeight.bold,
  //                                 fontSize: 16),
  //                           ),
  //                         ),
  //                       ),
  //                       SizedBox(width: 20),
  //                       Container(
  //                         width: 140,
  //                         decoration: BoxDecoration(
  //                           color:
  //                               Color(0xFFffffff), // Set green background color
  //                           borderRadius: BorderRadius.circular(8),
  //                           border:
  //                               Border.all(color: Color(0xFF117a5d), width: 1),
  //                         ),
  //                         child: ElevatedButton(
  //                           onPressed: () {
  //                             Navigator.pop(context);
  //                           },
  //                           style: ElevatedButton.styleFrom(
  //                             primary: Colors
  //                                 .transparent, // Set transparent background
  //                             elevation: 0, // Remove elevation
  //                             shape: RoundedRectangleBorder(
  //                               borderRadius: BorderRadius.circular(8),
  //                             ),
  //                           ),
  //                           child: Text(
  //                             "Cancel",
  //                             style: TextStyle(
  //                                 color: Color(0xFF117a5d),
  //                                 fontWeight: FontWeight.bold,
  //                                 fontSize: 16),
  //                           ),
  //                         ),
  //                       ),
  //                     ],
  //                   ))
  //             ],
  //           ),
  //         );
  //       });
  //     },
  //   );
  // }

  // IconButton buildIconButton(IconData icon, int index, StateSetter setState) {
  //   return IconButton(
  //     icon: GestureDetector(
  //       onTap: () {
  //         setState(() {
  //           selectedIconIndex = index;
  //           colorIcon =
  //               selectedIconIndex == index ? Color(0xFFFFD700) : Colors.black54;
  //         });
  //       },
  //       child: Icon(
  //         icon,
  //         size: 40,
  //         color: selectedIconIndex == index ? colorIcon : Colors.black54,
  //       ),
  //     ),
  //     onPressed: () {
  //     },
  //   );
  // }
}
