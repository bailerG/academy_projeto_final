import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
      resizeToAvoidBottomInset: false,
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
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 50),
                      child: AppTitle(
                        title: AppLocalizations.of(context)!.loginWelcome,
                      ),
                    ),
                    AppHeader(
                      header: AppLocalizations.of(context)!.headerUsername,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(
                        top: 8,
                        bottom: 8,
                      ),
                      child: _UsernameTextField(),
                    ),
                    AppHeader(
                      header: AppLocalizations.of(context)!.headerPassword,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(
                        top: 8,
                        bottom: 32,
                      ),
                      child: _PasswordTextField(),
                    ),
                    const Row(
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

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<LoginScreenState>(context, listen: false);

    String? validator(String? value) {
      if (value == null) {
        return AppLocalizations.of(context)!.emptyUser;
      }
      return null;
    }

    return AppTextField(
      controller: state.usernameController,
      hint: AppLocalizations.of(context)!.typeUser,
      validator: validator,
      icon: const Icon(Icons.account_circle),
    );
  }
}

class _PasswordTextField extends StatelessWidget {
  const _PasswordTextField();

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<LoginScreenState>(context, listen: true);

    String? validator(String? value) {
      if (value == null) {
        return AppLocalizations.of(context)!.emptyPassword;
      }
      return null;
    }

    return AppTextField(
      controller: state.passwordController,
      validator: validator,
      hint: AppLocalizations.of(context)!.typePassword,
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
      if (!loginState.formState.currentState!.validate()) {
        return;
      }

      try {
        await loginState.login();
        if (context.mounted) {
          mainState.setLoggedUser(loginState.loggedUser);
          await Navigator.of(context)
              .pushReplacementNamed(MainScreen.routeName);
        }
      } on LoginError {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(AppLocalizations.of(context)!.wrongLogin),
            ),
          );
        }
      }
    }

    return AppLargeButton(
      onPressed: onPressed,
      text: AppLocalizations.of(context)!.login,
    );
  }
}
