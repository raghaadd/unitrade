import 'package:flutter/material.dart';
import 'package:flutter_paypal_checkout/flutter_paypal_checkout.dart';
import 'package:flutter_project_1st/Notificationpage/appBarNotification.dart';
import 'package:flutter_project_1st/generated/l10n.dart';
import 'package:flutter_project_1st/payment/helpers/ui_helper.dart';

class PaypalScreen extends StatefulWidget {
  const PaypalScreen({Key? key, required this.price,required this.itemname});
  final String price;
  final String itemname;

  @override
  State<PaypalScreen> createState() => _PaypalScreenState();
}

class _PaypalScreenState extends State<PaypalScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _startPaypalCheckout();
    });
  }

  _startPaypalCheckout() async {
    await Navigator.of(context).push(MaterialPageRoute(
      builder: (BuildContext context) => PaypalCheckout(
        sandboxMode: true,
        clientId:
            "ATVcaW1rB8zTpuPyT_5-r6U9lRDnuWNZ9_YMLnJ72Ja8qn5WooMbq1ApzDWZAFS0Umh0S4W2OQCasV_X",
        secretKey:
            "ELPJQdIe3uXYPeIM99iZOsNPB56TBtB9TCyP9gdEJZpYnK2gMEFuh2q3n3T8hL_9Y93qVm4pUDTNJpxg",
        returnURL: "success.snippetcoder.com",
        cancelURL: "cancel.snippetcoder.com",
        transactions: [
          {
            "amount": {
              "total": widget.price,
              "currency": "ILS",
              "details": {
                "subtotal": widget.price,
                "shipping": '0',
                "shipping_discount": 0
              }
            },
            "description": "The payment transaction description.",
            "item_list": {
              "items": [
                {
                  "name": widget.itemname,
                  "quantity": 1,
                  "price": widget.price,
                  "currency": "ILS"
                },
              ],
            }
          }
        ],
        note: "Contact us for any questions on your order.",
        onSuccess: (Map params) async {
          print("onSuccess: $params");
          UIHelper.showAlerDialog('Payment Successfully', title: 'Success');
        },
        onError: (error) {
          print("onError: $error");
          UIHelper.showAlerDialog('Unable to complete the Payment',
              title: 'Error');
        },
        onCancel: () {
          UIHelper.showAlerDialog('Payment Canceled', title: 'Cancel');
        },
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: appBarNotification(
          title: S.of(context).PayPal_check,
          fromUserprofiel: false,
        ),
      ),
      body: Center(
        child:
            CircularProgressIndicator(), // Show a loader while initiating the checkout
      ),
    );
  }
}
