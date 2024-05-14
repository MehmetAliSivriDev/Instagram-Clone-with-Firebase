import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/init/providers.dart';
import 'core/lang/locale_list.dart';
import 'core/routes/router.dart';
import 'core/routes/routes.dart';
import 'core/theme/theme_notifier.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await EasyLocalization.ensureInitialized();

  runApp(MultiProvider(
      providers: Providers.getProviders,
      builder: (context, child) => EasyLocalization(
          supportedLocales: LocaleList.getSupportedLocales(),
          path: 'assets/lang',
          fallbackLocale: LocaleList.getLocale(localeName: LocaleNames.ENGLISH),
          child: const MyApp())));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      onGenerateRoute: CRouter.generateRoute,
      initialRoute: Routes.SPLASH,
      title: 'Instagram Clone',
      theme: context.watch<ThemeNotifier>().currentTheme,
    );
  }
}
