import 'package:flutter/material.dart';

class CustomAlertContent extends StatelessWidget {
  final String alertText;

  CustomAlertContent({required this.alertText});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              this.alertText,
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            // SizedBox(height: 5),
            // Add additional content or styling as needed
          ],
        ),
      ),
    );
  }
}
