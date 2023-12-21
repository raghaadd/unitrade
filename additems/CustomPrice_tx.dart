import 'package:flutter/material.dart';
import 'package:flutter_project_1st/generated/l10n.dart';

class PriceTextField extends StatefulWidget {
  const PriceTextField({Key? key, required this.controller}) : super(key: key);
  final TextEditingController controller;

  @override
  State<PriceTextField> createState() => _PriceTextFieldState();
}

class _PriceTextFieldState extends State<PriceTextField> {
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
        padding: EdgeInsets.symmetric(horizontal: 0),
        child: TextFormField(
          keyboardType: TextInputType.number,
          controller: widget.controller,
          decoration: InputDecoration(
            hintText: S.of(context).price,
            contentPadding: EdgeInsets.all(15),
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
              return 'Please Enter Price Item';
            }
            return null;
          },
        ),
      ),
    );
  }
}
