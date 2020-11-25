import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginModel extends ChangeNotifier {
  String mail = '';
  String password = '';

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future login() async {
    if (mail.isEmpty) {
      throw ('Please enter your e-mail address');
    }
    if (password.isEmpty) {
      throw ('Please enter your password');
    }
    final result = await _auth.signInWithEmailAndPassword(
      email: mail,
      password: password,
    );

    final uid = result.user.email;

  }
}