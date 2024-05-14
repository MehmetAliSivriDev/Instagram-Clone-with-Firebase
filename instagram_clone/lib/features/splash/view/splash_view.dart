import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../../product/constant/product_color.dart';
import '../../../product/extension/lottie_extension.dart';
import '../view_model/splash_view_model.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<SplashViewModel>(context).navigate(context: context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ProductColor.instance.transparent,
        ),
        body: Center(
          child: SizedBox(
              width: context.sized.dynamicHeight(0.15),
              height: context.sized.dynamicHeight(0.15),
              child: Lottie.asset(Lotties.splash.getPath, repeat: true)),
        ));
  }
}
