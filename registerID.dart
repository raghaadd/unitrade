import 'package:flutter/material.dart';

class UserData with ChangeNotifier {
  String registerID = '';

  void setRegisterID(String newRegisterID) {
    registerID = newRegisterID;
    notifyListeners();
  }
}
