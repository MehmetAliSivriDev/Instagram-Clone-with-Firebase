import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../product/constant/product_color.dart';

class DarkTheme {
  static DarkTheme? _instance;
  static DarkTheme get instance {
    _instance ??= DarkTheme._init();
    return _instance!;
  }

  DarkTheme._init();

  ThemeData get darkTheme => dark;

  ThemeData dark = ThemeData(
    appBarTheme: AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        iconTheme: IconThemeData(color: ProductColor.instance.white)),
    useMaterial3: true,
    scaffoldBackgroundColor: ProductColor.instance.black,
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: ProductColor.instance.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // Border radius
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
      foregroundColor: ProductColor.instance.blue,
    )),
    iconTheme: IconThemeData(color: ProductColor.instance.white),
  );
}
