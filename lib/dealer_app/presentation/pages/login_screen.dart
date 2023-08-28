import 'package:desafio_academy_flutter/dealer_app/presentation/pages/user_registration_screen.dart';
import 'package:provider/provider.dart';
import '/main.dart';
import 'package:flutter/material.dart';
import '../state/login_screen_state.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  static const routeName = '/login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Column(
        children: [
          LoginForm(),
        ],
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginScreenState(),
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //------------------- Welcome title -------------------
            Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: Title(
                color: accentColor,
                child: const Text(
                  'Welcome!',
                  textScaleFactor: 2.0,
                  style: TextStyle(
                    color: accentColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            const Text(
              'Username',
              textScaleFactor: 1.3,
              style: TextStyle(
                color: accentColor,
                fontWeight: FontWeight.w700,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(
                top: 10,
                bottom: 10,
              ),
              // ------------------- Username text field -------------------
              child: UsernameTextField(),
            ),
            const Text(
              'Password',
              textScaleFactor: 1.3,
              style: TextStyle(
                color: accentColor,
                fontWeight: FontWeight.w700,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(
                top: 10,
                bottom: 10,
              ),
              // ------------------- Password text field -------------------
              child: PasswordTextField(),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // -------------------- Login button --------------------
                  LoginButton(),
                ],
              ),
            ),
            const Padding(
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
                  // ------------------- Register text button -------------------
                  RegisterButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UsernameTextField extends StatelessWidget {
  const UsernameTextField({super.key});

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

class PasswordTextField extends StatelessWidget {
  const PasswordTextField({super.key});

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

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

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

class RegisterButton extends StatelessWidget {
  const RegisterButton({super.key});

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
