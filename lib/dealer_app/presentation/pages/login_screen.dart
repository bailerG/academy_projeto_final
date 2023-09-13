import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/login_screen_state.dart';
import '../state/main_state.dart';
import '../utils/header.dart';
import '../utils/large_button.dart';
import '../utils/text_field.dart';
import '../utils/title.dart';
import 'main_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  static const routeName = '/login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Column(
        children: [
          _LoginScreenStructure(),
        ],
      ),
    );
  }
}

class _LoginScreenStructure extends StatelessWidget {
  const _LoginScreenStructure();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginScreenState(),
      child: Consumer<LoginScreenState>(
        builder: (context, state, child) {
          return SingleChildScrollView(
            child: Form(
              key: state.formState,
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
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _UsernameTextField extends StatelessWidget {
  const _UsernameTextField();

  String? _validator(String? value) {
    if (value == null) {
      return 'Please type your username';
    }
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
    if (value == null) {
      return 'Please type your password';
    }
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

  @override
  Widget build(BuildContext context) {
    final loginState = Provider.of<LoginScreenState>(context, listen: true);
    final mainState = Provider.of<MainState>(context, listen: false);

    void onPressed() async {
      if (loginState.formState.currentState!.validate()) {
        try {
          await loginState.login();
          if (context.mounted) {
            mainState.setLoggedUser(loginState.loggedUser);
            Navigator.of(context).pushReplacementNamed(MainScreen.routeName);
          }
        } on LoginError {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Username/Password incorrect.'),
              ),
            );
          }
        }
      }
    }

    return AppLargeButton(
      onPressed: onPressed,
      text: 'Login',
    );
  }
}
