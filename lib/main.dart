import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../dealer_app/presentation/pages/login_screen.dart';
import 'dealer_app/presentation/pages/user_registration_screen.dart';

const accentColor = Color.fromRGBO(134, 46, 46, 1);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      title: 'Anderson Automoveis',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: const ColorScheme.light(
          primary: accentColor,
        ),
      ),
      routes: {
        LoginScreen.routeName: (context) => const LoginScreen(),
        UserRegistrationScreen.routeName: (context) =>
            const UserRegistrationScreen(),
      },
      initialRoute: LoginScreen.routeName,
    );
  }
}
