import 'package:flutter/material.dart';

class ItemNameTextField extends StatefulWidget {
  const ItemNameTextField({Key? key, required this.controller,required this.itemName})
      : super(key: key);
  final TextEditingController controller;
  final String itemName;

  @override
  State<ItemNameTextField> createState() => _ItemNameTextFieldState();
}

class _ItemNameTextFieldState extends State<ItemNameTextField> {
  var obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // Shadow color
            blurRadius: 3, // Blur radius
            offset: Offset(0, 1), // Offset
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: TextFormField(
          controller: widget.controller,
          decoration: InputDecoration(
            hintText: widget.itemName,
            contentPadding: const EdgeInsets.all(15),
            filled: true,
            fillColor: Colors.grey.shade200, // Background color
            border: OutlineInputBorder(borderSide: BorderSide.none),
            hintStyle: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade600,
            ),
          ),
          style: TextStyle(fontSize: 20, color: Color(0xFF000000)),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please Enter Item name';
            }
            return null;
          },
        ),
      ),
    );
  }
}
