import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/main.dart';
import '../state/login_screen_state.dart';
import '../utils/header.dart';
import '../utils/large_button.dart';
import '../utils/text_field.dart';
import '../utils/title.dart';
import 'user_registration_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  static const routeName = '/login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Column(
        children: [
          _LoginForm(),
        ],
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginScreenState(),
      child: const Padding(
        padding: EdgeInsets.all(40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 50),
              child: AppTitle(title: 'Welcome!'),
            ),
            AppHeader(header: 'Username'),
            Padding(
              padding: EdgeInsets.only(
                top: 8,
                bottom: 8,
              ),
              child: _UsernameTextField(),
            ),
            AppHeader(header: 'Password'),
            Padding(
              padding: EdgeInsets.only(
                top: 8,
                bottom: 32,
              ),
              child: _PasswordTextField(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _LoginButton(),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  _RegisterButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _UsernameTextField extends StatelessWidget {
  const _UsernameTextField();

  String? _validator(String? value) {
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<LoginScreenState>(context, listen: false);

    return AppTextField(
      controller: state.usernameController,
      hint: 'Type in your Username',
      validator: _validator,
      icon: const Icon(Icons.account_circle),
    );
  }
}

class _PasswordTextField extends StatelessWidget {
  const _PasswordTextField();

  String? _validator(String? value) {
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<LoginScreenState>(context, listen: true);

    return AppTextField(
      controller: state.passwordController,
      validator: _validator,
      hint: 'Type in your password',
      icon: const Icon(Icons.security),
      obscureText: state.obscureText,
      obscureTextButton: IconButton(
        onPressed: state.toggleObscureText,
        icon: state.obscureText
            ? const Icon(Icons.toggle_on_outlined)
            : const Icon(Icons.toggle_off_rounded),
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton();

  void onPressed() {
    return;
  }

  @override
  Widget build(BuildContext context) {
    // final state = Provider.of<LoginScreenState>(context, listen: false);

    return AppLargeButton(
      onPressed: onPressed,
      text: 'Login',
    );
  }
}

class _RegisterButton extends StatelessWidget {
  const _RegisterButton();

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.of(context).pushNamed(UserRegistrationScreen.routeName);
      },
      child: const Text(
        'Register',
        style: TextStyle(
          color: accentColor,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
