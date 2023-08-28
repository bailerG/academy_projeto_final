import 'package:flutter/material.dart';

class LoginScreenState with ChangeNotifier {
  final formState = GlobalKey<FormState>();

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  bool obscureText = true;

  void toggleObscureText() {
    obscureText = !obscureText;
    notifyListeners();
  }
}
