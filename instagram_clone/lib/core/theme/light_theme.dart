import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../product/constant/product_color.dart';

class LightTheme {
  static LightTheme? _instance;
  static LightTheme get instance {
    _instance ??= LightTheme._init();
    return _instance!;
  }

  LightTheme._init();

  ThemeData get lightTheme => light;

  ThemeData light = ThemeData(
    appBarTheme:
        const AppBarTheme(systemOverlayStyle: SystemUiOverlayStyle.dark),
    useMaterial3: true,
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // Border radius
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
      foregroundColor: Colors.blue,
    )),
    iconTheme: IconThemeData(color: ProductColor.instance.black),
  );
}
