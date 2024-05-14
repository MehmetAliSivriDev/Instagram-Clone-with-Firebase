import 'package:flutter/material.dart';

class ProductColor {
  static ProductColor? _instance;
  static ProductColor get instance {
    _instance ??= ProductColor._init();
    return _instance!;
  }

  ProductColor._init();

  var transparent = Colors.transparent;

  var black = Colors.black;
  var white = Colors.white;
  var blue = Colors.blue;
  var red = const Color(0xffb20a2c);

  var grey = Colors.grey;
  var grey100 = Colors.grey[100];
  var grey200 = Colors.grey[200];
  var grey300 = Colors.grey[300];
  var grey400 = Colors.grey[400];
  var grey600 = Colors.grey[600];
  var grey800 = Colors.grey[800];
  var grey900 = Colors.grey[900];
}
