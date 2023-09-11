import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../dealer_app/presentation/pages/login_screen.dart';
import 'dealer_app/presentation/pages/home_screen.dart';
import 'dealer_app/presentation/pages/user_registration_screen.dart';
import 'dealer_app/presentation/state/main_state.dart';

const accentColor = Color.fromRGBO(134, 46, 46, 1);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MainState(),
      child: Consumer<MainState>(
        builder: (context, state, child) {
          return MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            title: 'Anderson Automoveis',
            theme: ThemeData(
              useMaterial3: true,
              colorScheme: state.lightTheme
                  ? const ColorScheme.light(
                      primary: accentColor,
                      secondary: Colors.black87,
                    )
                  : const ColorScheme.dark(
                      primary: accentColor,
                      secondary: Colors.white70,
                    ),
            ),
            routes: {
              LoginScreen.routeName: (context) => const LoginScreen(),
              UserRegisterScreen.routeName: (context) =>
                  const UserRegisterScreen(),
              HomeScreen.routeName: (context) => const HomeScreen(),
            },
            initialRoute: LoginScreen.routeName,
          );
        },
      ),
    );
  }
}
