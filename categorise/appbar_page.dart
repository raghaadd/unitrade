import 'package:flutter/material.dart';
import 'package:flutter_project_1st/homepage/hidden_drawer.dart';
import 'package:intl/intl.dart';

class appBarPage extends StatelessWidget {
  const appBarPage({Key? key, required this.slidepage});
  final bool slidepage;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      //  backgroundColor: Color(0xFFffffff).withOpacity(0.05),
      backgroundColor: const Color(0xFF117a5d).withOpacity(0.7),
      leading: IconButton(
        icon: Icon(
          Intl.getCurrentLocale() == 'ar'
              ? Icons.arrow_forward_ios_outlined
              : Icons.arrow_back_ios_new_outlined, // Back arrow icon
          color: Colors.black, // Change the color
          size: 30, // Change the size
        ), // Back arrow icon
        onPressed: () {
          if (this.slidepage) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => HiddenDrawer(
                          page: 0,
                        )));
          } else {
            Navigator.pop(context); // Return to the previous page
          }
        },
      ),
      actions: <Widget>[
        IconButton(
          onPressed: () {
            // Handle notification icon press
          },
          icon: const Icon(
            Icons.search,
            size: 30,
            color: Colors.black,
          ),
        ),
        IconButton(
          onPressed: () {
            // Handle notification icon press
          },
          icon: const Icon(
            Icons.filter_list,
            size: 30,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
