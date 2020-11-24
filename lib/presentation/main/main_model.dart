import 'package:flutter/material.dart';

class MainModel extends ChangeNotifier {
  String myText = '';

  void changeKboyText() {
    myText = '';
    notifyListeners();
  }
}