import 'package:flutter/material.dart';

class ProductBorderRadius extends BorderRadius {
  ProductBorderRadius.circularLow() : super.circular(5);
  ProductBorderRadius.circularNormal() : super.circular(10);
  ProductBorderRadius.circularNormalPlus() : super.circular(15);
  ProductBorderRadius.circularHigh() : super.circular(20);
}
