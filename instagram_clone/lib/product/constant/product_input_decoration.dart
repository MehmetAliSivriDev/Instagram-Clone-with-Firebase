import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import 'product_color.dart';

class ProductInputDecoration extends InputDecoration {
  ProductInputDecoration.loginTF(BuildContext context, String hintText)
      : super(
          hintStyle: context.general.textTheme.bodyMedium!
              .copyWith(color: ProductColor.instance.grey),
          border: const OutlineInputBorder(borderSide: BorderSide.none),
          hintText: hintText,
        );
}
