import 'package:flutter/material.dart';

import '../../entities/user.dart';
import '../../usecases/login_verification.dart';
import '../pages/login_screen.dart';

/// State controller of [LoginScreen] managing the data displayed.
class LoginScreenState with ChangeNotifier {
  /// Constructs an instance of [LoginScreenState].
  LoginScreenState();

  /// The form controller of this screen.
  final formState = GlobalKey<FormState>();

  final _usernameController = TextEditingController();

  /// The value inside username text field.
  TextEditingController get usernameController => _usernameController;
  final _passwordController = TextEditingController();

  /// The value inside password text field.
  TextEditingController get passwordController => _passwordController;
  User? _loggedUser;

  /// The user logged successfully.
  User get loggedUser => _loggedUser!;

  /// Whether password field hides text or not.
  bool obscureText = true;

  /// Toggles [obscureText] on/off.
  void toggleObscureText() {
    obscureText = !obscureText;
    notifyListeners();
  }

  /// Verifies if the typed information is from an registered user.
  Future<void> login() async {
    final query = LoginVerification();
    final result = await query.verifyLogin(
      usernameController.text,
      passwordController.text,
    );
    if (result == null || !result.isActive) {
      throw LoginError();
    } else {
      _setLoggedUser(result);
    }
  }

  void _setLoggedUser(User user) {
    _loggedUser = user;
    notifyListeners();
  }
}

/// Error thrown whenever login is not successful.
class LoginError implements Exception {
  @override
  String toString() {
    return 'Username/password incorrect.';
  }
}
