import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
  ),
  colorScheme: ColorScheme.light(
    background: Colors.white,
    primary: Colors.grey[200]!,
    secondary: Colors.grey[100]!,
    surface: Colors.black,
  ) 
);