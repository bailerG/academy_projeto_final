import 'package:flutter/material.dart';

class LoginScreenState with ChangeNotifier {
  final formState = GlobalKey<FormState>();

  static final usernameController = TextEditingController();
  static final passwordController = TextEditingController();
  // static bool _obscureText = false;
}
