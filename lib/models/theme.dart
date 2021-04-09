import 'package:flutter/material.dart';
import 'package:fridge/models/theme_preference.dart';

class ThemeProvider  with ChangeNotifier {
  ThemePreference themePreference = ThemePreference();
  bool _isWhite = false;

  bool get isWhiteTheme => _isWhite;

  set setWhiteTheme(bool value) {
    _isWhite = value;
    themePreference.setTheme(value);
    notifyListeners();
  }
}