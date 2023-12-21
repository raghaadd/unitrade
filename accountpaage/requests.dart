import 'package:flutter/material.dart';

class itemRequests extends StatefulWidget {
  const itemRequests({super.key});

  @override
  State<itemRequests> createState() => _itemRequestsState();
}

class _itemRequestsState extends State<itemRequests> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF117a5d),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.grey.shade200,
            size: 30,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Requsets",
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
      ),
    );
  }
}
