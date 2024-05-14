import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../core/lang/locale_strings.dart';
import '../service/login_service.dart';
import '../../../product/constant/product_color.dart';
import '../../../product/util/custom_snackbar.dart';

import '../../../core/routes/routes.dart';

class LoginViewModel extends ChangeNotifier {
  final ILoginService _loginService = LoginService();
  bool isLoading = false;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  void _changeLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }

  void login(BuildContext context) async {
    if (formKey.currentState != null && formKey.currentState!.validate()) {
      _changeLoading();
      final response = await _loginService.login(
          email: emailController.text, password: passwordController.text);
      await Future.delayed(const Duration(milliseconds: 500));
      _changeLoading();

      if (context.mounted) {
        if (response) {
          Navigator.pushNamedAndRemoveUntil(
              context, Routes.NAVIGATION, (route) => false);
        } else {
          CustomSnackbar.show(context,
              message: LocaleStrings.errorLogin.tr(),
              backgroundColor: ProductColor.instance.red);
          _cleanControllersText();
        }
      }
    }
  }

  void _cleanControllersText() {
    emailController.clear();
    passwordController.clear();
    notifyListeners();
  }
}
