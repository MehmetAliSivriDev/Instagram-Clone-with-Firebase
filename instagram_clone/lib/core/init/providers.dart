import '../../features/login/view_model/login_view_model.dart';
import '../../features/signup/view_model/signup_view_model.dart';

import '../../features/add/view_model/add_view_model.dart';
import '../../features/navigation/view_model/navigation_view_model.dart';

import '../../features/profile/viewModel/profile_view_model.dart';
import '../theme/theme_notifier.dart';
import '../../features/splash/view_model/splash_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class Providers {
  static List<SingleChildWidget> getProviders = [
    ChangeNotifierProvider(
      create: (context) => ThemeNotifier.instance,
    ),
    ChangeNotifierProvider(
      create: (context) => SplashViewModel(),
    ),
    ChangeNotifierProvider(
      create: (context) => SignupViewModel(),
    ),
    ChangeNotifierProvider(
      create: (context) => LoginViewModel(),
    ),
    ChangeNotifierProvider(
      create: (context) => NavigationViewModel(),
    ),
    ChangeNotifierProvider(
      create: (context) => AddViewModel(),
    ),
    ChangeNotifierProvider(
      create: (context) => ProfileViewModel(),
    ),
  ];
}
