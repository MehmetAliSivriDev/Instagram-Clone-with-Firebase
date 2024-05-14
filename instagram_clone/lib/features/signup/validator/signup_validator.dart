import 'package:easy_localization/easy_localization.dart';

import '../../../core/lang/locale_strings.dart';

class SignupValidator {
  static SignupValidator? _instance;
  static SignupValidator get instance {
    _instance ??= SignupValidator._init();
    return _instance!;
  }

  SignupValidator._init();

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

  String? usernameValidator(String? value) {
    if (value == null || value == "") {
      return LocaleStrings.usernameValidator.tr();
    } else {
      return null;
    }
  }

  String? bioValidator(String? value) {
    if (value == null || value == "") {
      return LocaleStrings.bioValidator.tr();
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

  String? passConfirmValidator({String? value, required String pass}) {
    if (value == null || value == "" || value != pass) {
      return LocaleStrings.passConfirmValidator.tr();
    } else {
      return null;
    }
  }
}
