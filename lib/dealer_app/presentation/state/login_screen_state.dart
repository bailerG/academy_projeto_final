import 'package:flutter/material.dart';

import '../../entities/user.dart';
import '../../usecases/login_verification.dart';

class LoginScreenState with ChangeNotifier {
  final formState = GlobalKey<FormState>();

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  late User _loggedUser;

  TextEditingController get usernameController => _usernameController;
  TextEditingController get passwordController => _passwordController;
  User get loggedUser => _loggedUser;

  bool obscureText = true;

  void toggleObscureText() {
    obscureText = !obscureText;
    notifyListeners();
  }

  Future<void> login() async {
    final query = LoginVerification();
    final result = await query.verifyLogin(
      usernameController.text,
      passwordController.text,
    );
    if (result == null) {
      throw LoginError();
    } else {
      setLoggedUser(result);
    }
  }

  void setLoggedUser(User user) {
    _loggedUser = user;
    notifyListeners();
    return;
  }
}

class LoginError implements Exception {
  @override
  String toString() {
    return 'Username/password incorrect.';
  }
}
