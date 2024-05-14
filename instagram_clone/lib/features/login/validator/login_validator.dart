import 'package:easy_localization/easy_localization.dart';

import '../../../core/lang/locale_strings.dart';

class LoginValidator {
  static LoginValidator? _instance;
  static LoginValidator get instance {
    _instance ??= LoginValidator._init();
    return _instance!;
  }

  LoginValidator._init();

  String? emailValidator(String? value) {
    if (value == null ||
        value == "" ||
        !value.contains("@") ||
        !value.contains(".com")) {
      return LocaleStrings.emailValidator.tr();
    } else {
      return null;
    }
  }

  String? passValidator(String? value) {
    if (value == null || value == "" || value.length < 6) {
      return LocaleStrings.passValidator.tr();
    } else {
      return null;
    }
  }
}
