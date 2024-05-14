import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../core/lang/locale_strings.dart';
import '../../../core/routes/routes.dart';
import '../../../product/constant/product_color.dart';
import '../../../product/util/custom_exception.dart';
import '../../../product/util/custom_snackbar.dart';
import '../../../product/util/image_upload_manager.dart';
import '../service/signup_service.dart';

class SignupViewModel extends ChangeNotifier {
  final ISignupService _signupService = SignupService();

  bool isLoading = false;
  File? imageFile;

  final formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();

  void _changeLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }

  Future<void> signup(BuildContext context) async {
    if (formKey.currentState != null && formKey.currentState!.validate()) {
      if (imageFile != null && imageFile != File("")) {
        try {
          _changeLoading();
          await _signupService.signup(
              email: emailController.text,
              password: passwordController.text,
              passwordConfirm: passwordConfirmController.text,
              username: usernameController.text,
              bio: bioController.text,
              profile: imageFile!);
          await Future.delayed(const Duration(milliseconds: 500));
          _changeLoading();

          if (context.mounted) {
            Navigator.pushNamedAndRemoveUntil(
                context, Routes.NAVIGATION, (route) => false);
          }
        } on CustomException catch (e) {
          if (context.mounted) {
            CustomSnackbar.show(context,
                message: e.message, backgroundColor: ProductColor.instance.red);
          }

          if (context.mounted) {
            Navigator.pushNamedAndRemoveUntil(
                context, Routes.LOGIN, (route) => false);
          }
          _cleanControllersText();
        }
      } else {
        CustomSnackbar.show(context,
            message: LocaleStrings.selectPhoto.tr(),
            backgroundColor: ProductColor.instance.red);
      }
    }
  }

  Future<void> imageUpload() async {
    File? uploadedImage = await ImageUploadManager().uploadImage('gallery');

    // ignore: unnecessary_null_comparison
    if (uploadedImage != null) {
      imageFile = uploadedImage;
      notifyListeners();
    }
  }

  void _cleanControllersText() {
    emailController.clear();
    passwordController.clear();
    passwordConfirmController.clear();
    usernameController.clear();
    bioController.clear();
    notifyListeners();
  }
}
