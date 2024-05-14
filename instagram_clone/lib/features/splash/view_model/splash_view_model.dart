import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../core/routes/routes.dart';

class SplashViewModel extends ChangeNotifier {
  SplashViewModel();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> navigate({required BuildContext context}) async {
    User? user = _auth.currentUser;
    await Future.delayed(const Duration(milliseconds: 2500));

    if (context.mounted) {
      if (user != null) {
        Navigator.pushNamedAndRemoveUntil(
            context, Routes.NAVIGATION, (route) => false);
      } else {
        Navigator.pushNamedAndRemoveUntil(
            context, Routes.LOGIN, (route) => false);
      }
    }
  }
}
