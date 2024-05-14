import 'package:flutter/material.dart';
import '../../features/add/view/add_post_content_view.dart';
import '../../features/navigation/view/navigation.dart';
import '../../features/splash/view/splash_view.dart';
import '../../features/home/view/home_view.dart';
import 'routes.dart';
import '../../features/login/view/login_view.dart';
import '../../features/signup/view/signup_view.dart';

class CRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.SPLASH:
        return MaterialPageRoute(
          builder: (_) => const SplashView(),
        );

      case Routes.NAVIGATION:
        return MaterialPageRoute(
          builder: (_) => const Navigation(),
        );

      case Routes.LOGIN:
        return MaterialPageRoute(
          builder: (_) => LoginView(),
        );

      case Routes.SIGNUP:
        return MaterialPageRoute(
          builder: (_) => SignupView(),
        );

      case Routes.HOME:
        return MaterialPageRoute(
          builder: (_) => const HomeView(),
        );

      case Routes.ADD_POST_CONTENT:
        return MaterialPageRoute(
          builder: (_) => const AddPostContentView(),
        );

      default:
        return MaterialPageRoute(
            builder: (_) => const Center(
                  child: CircularProgressIndicator(),
                ));
    }
  }
}
