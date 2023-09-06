import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
}
