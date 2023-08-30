import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/main.dart';
import '../state/login_screen_state.dart';
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
            //------------------- Welcome title ------------------- //
            _WelcomeTitle(),
            // ------------------- Username text field ------------------- //
            Text(
              'Username',
              textScaleFactor: 1.3,
              style: TextStyle(
                color: accentColor,
                fontWeight: FontWeight.w700,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 10,
                bottom: 10,
              ),
              child: _UsernameTextField(),
            ),
            // ------------------- Password text field ------------------- //
            Text(
              'Password',
              textScaleFactor: 1.3,
              style: TextStyle(
                color: accentColor,
                fontWeight: FontWeight.w700,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 10,
                bottom: 30,
              ),
              child: _PasswordTextField(),
            ),
            // -------------------- Login button -------------------- //
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _LoginButton(),
              ],
            ),
            // ------------------- Register text button ------------------- //
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

class _WelcomeTitle extends StatelessWidget {
  const _WelcomeTitle();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50),
      child: Title(
        color: accentColor,
        child: const Text(
          'Welcome!',
          textScaleFactor: 2.5,
          style: TextStyle(
            color: accentColor,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class _UsernameTextField extends StatelessWidget {
  const _UsernameTextField();

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginScreenState>(
      builder: (context, state, child) {
        return TextFormField(
          controller: state.usernameController,
          keyboardType: TextInputType.text,
          decoration: const InputDecoration(
            hintText: 'Type in your username',
            prefixIcon: Icon(Icons.person),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _PasswordTextField extends StatelessWidget {
  const _PasswordTextField();

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginScreenState>(
      builder: (context, state, child) {
        return TextFormField(
          controller: state.passwordController,
          keyboardType: TextInputType.text,
          obscureText: state.obscureText,
          decoration: InputDecoration(
            hintText: 'Type in your password',
            prefixIcon: const Icon(Icons.security),
            suffixIcon: IconButton(
              onPressed: () {
                state.toggleObscureText();
              },
              icon: state.obscureText
                  ? const Icon(Icons.toggle_on_outlined)
                  : const Icon(Icons.toggle_off_rounded),
            ),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton();

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginScreenState>(
      builder: (context, state, child) {
        return ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            minimumSize: Size(
              MediaQuery.of(context).size.width / 1.26,
              MediaQuery.of(context).size.height / 16,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            backgroundColor: accentColor,
            foregroundColor: Colors.white,
          ),
          child: const Text('Login'),
        );
      },
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
