import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../entities/user.dart';
import '../pages/admin_panel_screen.dart';
import '../pages/home_screen.dart';
import '../pages/navigation_bar.dart';
import '../pages/sale/sales_screen.dart';
import '../pages/settings_screen.dart';
import '../pages/vehicle/vehicle_register_screen.dart';

/// Shared preferences key to the app theme.
const appThemeKey = 'appThemeKey';

/// Shared preferences key to the app language.
const appLanguageKey = 'appLanguageKey';

/// The main state controller of the app,
///
/// housing the core variables used everywhere.
class MainState with ChangeNotifier {
  /// Constructs an instance of [MainState].
  MainState() {
    _init();
  }

  User? _loggedUser;

  /// The current logged user.
  User? get loggedUser => _loggedUser;

  late final SharedPreferences _sharedPreferences;

  var _lightTheme = true;

  /// Whether light theme is selected or not.
  bool get lightTheme => _lightTheme;

  var _language = 'en';

  /// The selected language of the app.
  String get language => _language;

  /// Changes the [_language] value to the given [language].
  Future<void> toggleLanguage({required String language}) async {
    _language = language;
    await _sharedPreferences.setString(appLanguageKey, _language);
    notifyListeners();
  }

  /// Changes the [_lightTheme] value to the given [value].
  Future<void> toggleTheme({required bool value}) async {
    _lightTheme = value;
    await _sharedPreferences.setBool(appThemeKey, _lightTheme);
    notifyListeners();
  }

  void _init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _language = _sharedPreferences.getString(appLanguageKey) ?? 'en';
    _lightTheme = _sharedPreferences.getBool(appThemeKey) ?? true;
    notifyListeners();
  }

  int _selectedIndex = 0;

  /// The selected index from
  /// either [widgetOptionsAdmin] or [widgetOptionsAssociate].
  int get selectedIndex => _selectedIndex;

  /// [AppNavigationBar] page options for admin users.
  final List<Widget> widgetOptionsAdmin = <Widget>[
    const HomeScreen(),
    const VehicleRegisterScreen(),
    const AdminPanel(),
    const SalesScreen(),
    const SettingsScreen(),
  ];

  /// [AppNavigationBar] page options for associate users.
  final List<Widget> widgetOptionsAssociate = <Widget>[
    const HomeScreen(),
    const VehicleRegisterScreen(),
    const SalesScreen(),
    const SettingsScreen(),
  ];

  /// Changes the [_selectedIndex] to the given [index] value.
  void onItemTapped(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  /// Sets the [_loggedUser] to the given [user] value.
  void setLoggedUser(User? user) {
    _loggedUser = user;
    notifyListeners();
  }
}
