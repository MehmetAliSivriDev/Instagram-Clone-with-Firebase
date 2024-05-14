import 'package:flutter/material.dart';

class ProductPadding extends EdgeInsets {
  //All
  const ProductPadding.loginPadding() : super.all(20);
  const ProductPadding.allSuperLow5() : super.all(5);
  const ProductPadding.allLow() : super.all(10);
  //Symmetric
  const ProductPadding.horizontalLow8() : super.symmetric(horizontal: 8);
  const ProductPadding.horizontalNormal10() : super.symmetric(horizontal: 10);
  const ProductPadding.horizontalNormal15() : super.symmetric(horizontal: 15);
  //Only
  const ProductPadding.bottomLow() : super.only(bottom: 10);
  const ProductPadding.bottomNormal() : super.only(bottom: 20);
  const ProductPadding.bottomHigh() : super.only(bottom: 30);

  const ProductPadding.leftLow() : super.only(left: 10);
  const ProductPadding.leftNormal() : super.only(left: 20);
  const ProductPadding.leftHigh() : super.only(left: 30);
}
