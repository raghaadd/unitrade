// import 'package:flutter/material.dart';
// import 'package:pay/pay.dart';


// class GoogleWalletScreen extends StatefulWidget {
//   @override
//   _GoogleWalletScreenState createState() => _GoogleWalletScreenState();
// }

// class _GoogleWalletScreenState extends State<GoogleWalletScreen> {
//   Future<void> _checkGooglePayAvailability() async {
//     final isAvailable = await GooglePay.isAvailable();
//     if (isAvailable) {
//       print('Google Pay is available!');
//       // Implement Google Pay functionality here
//     } else {
//       print('Google Pay is not available!');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Google Pay Demo'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: _checkGooglePayAvailability,
//           child: Text('Check Google Pay Availability'),
//         ),
//       ),
//     );
//   }
// }
