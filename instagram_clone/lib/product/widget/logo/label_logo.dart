import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/theme_notifier.dart';
import '../../constant/product_color.dart';
import '../../extension/image_extension.dart';

class LabelLogo extends StatelessWidget {
  const LabelLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: context.sized.dynamicWidth(1),
        height: context.sized.dynamicHeight(0.1),
        child: Image.asset(
          Logos.lbl_Instagram_logo.path,
          color: context.watch<ThemeNotifier>().isLightTheme
              ? ProductColor.instance.black
              : ProductColor.instance.white,
        ));
  }
}
