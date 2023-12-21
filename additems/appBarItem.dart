import 'package:flutter/material.dart';

class appBarItem extends StatelessWidget {
  const appBarItem({Key? key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      //  backgroundColor: Color(0xFFffffff).withOpacity(0.05),
      backgroundColor: const Color(0xFFffffff).withOpacity(0.7),
      // leading: IconButton(
      //   icon: const Icon(
      //     Icons.arrow_back_ios_new_outlined, // Back arrow icon
      //     color: Colors.black, // Change the color
      //     size: 30, // Change the size
      //   ),
      //    // Back arrow icon
      //   onPressed: () {
      //     Navigator.pop(context); // Return to the previous page
      //   },
      // ),
      // actions: <Widget>[
      //   IconButton(
      //     onPressed: () {
      //       // Handle notification icon press
      //     },
      //     icon: const Icon(
      //       Icons.search,
      //       size: 30,
      //       color: Colors.black,
      //     ),
      //   ),
      //   IconButton(
      //     onPressed: () {
      //       // Handle notification icon press
      //     },
      //     icon: const Icon(
      //       Icons.filter_list,
      //       size: 30,
      //       color: Colors.black,
      //     ),
      //   ),
      // ],
    );
  }
}
