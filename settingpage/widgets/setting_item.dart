import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:intl/intl.dart';

class SettingItem extends StatelessWidget {
  final String title;
  final Color bgColor;
  final Color iconColor;
  final IconData icon;
  final Function() onTap;
  final String? value;
  final bool isDarkmode;
  const SettingItem({
    super.key,
    required this.title,
    required this.bgColor,
    required this.iconColor,
    required this.icon,
    required this.onTap,
    this.value,
    required this.isDarkmode,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: bgColor,
            ),
            child: Icon(
              icon,
              color: iconColor,
            ),
          ),
          SizedBox(width: 20),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: this.isDarkmode ? Colors.white : Colors.black,
            ),
          ),
          Spacer(),
          value != null
              ? Text(
                  value!,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                )
              : SizedBox(),
          SizedBox(width: 20),
          MouseRegion(
            child: GestureDetector(
              onTap: onTap,
              child: Container(
                decoration: BoxDecoration(
                  color: this.isDarkmode ? Colors.black12 : Colors.grey[300],
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Intl.getCurrentLocale() == 'ar'
                          ? Ionicons.chevron_back
                          : Ionicons.chevron_forward,
                      color: this.isDarkmode ? Colors.white : Colors.black,
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
