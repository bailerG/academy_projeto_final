import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../entities/user.dart';
import '../pages/admin_panel_screen.dart';
import '../pages/home_screen.dart';
import '../pages/report_generation_screen.dart';
import '../pages/vehicle_register_screen.dart';

const appThemeKey = 'appThemeKey';

class MainState with ChangeNotifier {
  MainState() {
    init();
  }

  late final SharedPreferences _sharedPreferences;

  var _lightTheme = true;

  bool get lightTheme => _lightTheme;

  void toggleTheme() {
    _lightTheme = !_lightTheme;
    _sharedPreferences.setBool(appThemeKey, _lightTheme);
    notifyListeners();
  }

  Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _lightTheme = _sharedPreferences.getBool(appThemeKey) ?? true;
    notifyListeners();
  }

  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  final List<Widget> widgetOptions = <Widget>[
    const HomeScreen(),
    const VehicleRegisterScreen(),
    const AdminPanel(),
    const ReportScreen(),
  ];

  void onItemTapped(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  User? _loggedUser;
  User? get loggedUser => _loggedUser;

  void setLoggedUser(User? user) {
    _loggedUser = user;
    notifyListeners();
  }
}
