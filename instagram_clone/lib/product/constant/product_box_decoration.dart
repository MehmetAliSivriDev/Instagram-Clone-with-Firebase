import 'package:flutter/material.dart';
import '../../core/theme/theme_notifier.dart';
import 'package:provider/provider.dart';
import 'product_color.dart';

class ProductBoxDecoration extends BoxDecoration {
  ProductBoxDecoration.loginTF(BuildContext context)
      : super(
            border: Border.all(
                color: context.watch<ThemeNotifier>().isLightTheme
                    ? ProductColor.instance.grey200 ??
                        ProductColor.instance.grey
                    : ProductColor.instance.black),
            borderRadius: BorderRadius.circular(8),
            color: context.watch<ThemeNotifier>().isLightTheme
                ? ProductColor.instance.grey100
                : ProductColor.instance.grey900);
}
