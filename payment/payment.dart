import 'package:flutter/material.dart';
import 'package:flutter_project_1st/Notificationpage/appBarNotification.dart';
import 'package:flutter_project_1st/generated/l10n.dart';
import 'package:flutter_project_1st/payment/defaultButton.dart';
import 'package:flutter_project_1st/payment/creditcard.dart';
import 'package:flutter_project_1st/payment/paypal.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen(
      {Key? key,
      required this.price,
      required this.itemname,
      required this.itemId,
      required this.RegisterID})
      : super(key: key);
  final String price;
  final String itemname;
  final String itemId;
  final String RegisterID;

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int? value = 0;
  final PaymentLabels = [
    'Credit card / Debit card',
    'Cash on delivery',
    'Paypal',
    'Google wallet',
  ];
  final PaymentIcons = [
    Icons.credit_card,
    Icons.money_off,
    Icons.payment,
    Icons.account_balance_wallet,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: appBarNotification(
          title: S.of(context).payment,
          fromUserprofiel: false,
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(height: 40),
          Expanded(
            child: ListView.separated(
              itemCount: PaymentLabels.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Radio(
                    activeColor: Color(0xFF117a5d).withOpacity(0.7),
                    value: index,
                    groupValue: value,
                    onChanged: (i) => setState(() => value = i),
                  ),
                  title: Text(
                    PaymentLabels[index],
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                  ),
                  trailing: Icon(
                    PaymentIcons[index],
                    color: Color(0xFF117a5d),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return Divider(
                  color: Colors.grey.shade300,
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: DefaultButton(
                btnText: S.of(context).Pay,
                onPressed: () {
                  switch (value) {
                    case 0: // Credit card selected
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              CreditCardScreen(itemId: widget.itemId,registerID:widget.RegisterID),
                        ),
                      );
                      break;
                    case 1: // Cash on delivery selected
                      // Navigator.of(context).push(
                      //   // MaterialPageRoute(
                      //   //   builder: (context) =>
                      //   //       //CashOnDeliveryPage(),
                      //   // ),
                      // );
                      break;
                    case 2: // Paypal selected
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => PaypalScreen(
                              price: widget.price,
                              itemname:
                                  widget.itemname), // Navigate to PaypalPage
                        ),
                      );
                      break;
                    // case 3: // Google wallet selected
                    //   Navigator.of(context).push(
                    //     MaterialPageRoute(
                    //       builder: (context) =>
                    //          GoogleWalletScreen(), // Navigate to GoogleWalletPage
                    //     ),
                    //   );
                    //   break;
                  }
                }),
          ),
          SizedBox(height: 40),
        ],
      ),
    );
  }
}
