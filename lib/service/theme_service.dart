import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeService {
  static const String _key = "theme";
  static const String _light = "light";
  static const String _dark = "dark";

  static Future<ThemeMode> getThemeMode() async {
    final shared = await SharedPreferences.getInstance();
    final theme = shared.getString(_key);
    if (theme == _light) {
      return ThemeMode.light;
    } else if (theme == _dark) {
      return ThemeMode.dark;
    } else {
      await setThemeMode(ThemeMode.dark);
      return ThemeMode.dark;
    }
  }

  static Future<void> setThemeMode(ThemeMode themeMode) async {
    final shared = await SharedPreferences.getInstance();
    if (themeMode == ThemeMode.light) {
      await shared.setString(_key, _light);
    } else {
      await shared.setString(_key, _dark);
    }
  }
}
