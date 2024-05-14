import 'package:flutter/material.dart';

import 'dark_theme.dart';
import 'light_theme.dart';

class ThemeNotifier extends ChangeNotifier {
  static ThemeNotifier? _instance;
  static ThemeNotifier get instance {
    _instance ??= ThemeNotifier._init();
    return _instance!;
  }

  ThemeNotifier._init();

  bool isLightTheme = true;

  void changeTheme() {
    isLightTheme = !isLightTheme;
    notifyListeners();
  }

  ThemeData get currentTheme =>
      isLightTheme ? LightTheme.instance.light : DarkTheme.instance.dark;
}
