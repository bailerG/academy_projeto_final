import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import '../dealer_app/presentation/pages/login_screen.dart';
import 'dealer_app/presentation/pages/admin_panel_screen.dart';
import 'dealer_app/presentation/pages/dealership/autonomy_options.dart';
import 'dealer_app/presentation/pages/dealership/dealership_list_screen.dart';
import 'dealer_app/presentation/pages/dealership/dealership_register_screen.dart';
import 'dealer_app/presentation/pages/home_screen.dart';
import 'dealer_app/presentation/pages/main_screen.dart';
import 'dealer_app/presentation/pages/sale/report_screen.dart';
import 'dealer_app/presentation/pages/sale/sales_list_screen.dart';
import 'dealer_app/presentation/pages/sale/sales_screen.dart';
import 'dealer_app/presentation/pages/settings_screen.dart';
import 'dealer_app/presentation/pages/user/user_list_screen.dart';
import 'dealer_app/presentation/pages/user/user_register_screen.dart';
import 'dealer_app/presentation/pages/vehicle/vehicle_options_screen.dart';
import 'dealer_app/presentation/pages/vehicle/vehicle_register_screen.dart';
import 'dealer_app/presentation/state/main_state.dart';
import 'l10n/l10n.dart';

const accentColor = Color.fromRGBO(134, 46, 46, 1);

void main() {
  runApp(
    const MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: MyApp(),
    ),
  );
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
            locale: const Locale('pt'),
            supportedLocales: L10n.all,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            routes: {
              LoginScreen.routeName: (context) {
                return const LoginScreen();
              },
              MainScreen.routeName: (context) {
                return const MainScreen();
              },
              HomeScreen.routeName: (context) {
                return const HomeScreen();
              },
              UserRegisterScreen.routeName: (context) {
                return const UserRegisterScreen();
              },
              VehicleRegisterScreen.routeName: (context) {
                return const VehicleRegisterScreen();
              },
              VehicleOptionsScreen.routeName: (context) {
                return const VehicleOptionsScreen();
              },
              AdminPanel.routeName: (context) {
                return const AdminPanel();
              },
              UserListScreen.routeName: (context) {
                return const UserListScreen();
              },
              DealershipRegisterScreen.routeName: (context) {
                return const DealershipRegisterScreen();
              },
              DealershipListScreen.routeName: (context) {
                return const DealershipListScreen();
              },
              AutonomyOptionsScreen.routeName: (context) {
                return const AutonomyOptionsScreen();
              },
              SalesScreen.routeName: (context) {
                return const SalesScreen();
              },
              ReportGenerationScreen.routeName: (context) {
                return const ReportGenerationScreen();
              },
              SalesListScreen.routeName: (context) {
                return const SalesListScreen();
              },
              SettingsScreen.routeName: (context) {
                return const SettingsScreen();
              },
            },
            initialRoute: LoginScreen.routeName,
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
          );
        },
      ),
    );
  }
}
