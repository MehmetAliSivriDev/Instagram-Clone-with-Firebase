import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:provider/provider.dart';
import '../../../core/lang/locale_strings.dart';
import '../../../core/routes/routes.dart';
import '../../../core/theme/theme_notifier.dart';
import '../../../product/constant/product_color.dart';
import '../../../product/constant/product_padding.dart';
import '../../../product/widget/logo/label_logo.dart';
import '../../../product/widget/text_form_field/custom_text_form_field.dart';
import '../validator/login_validator.dart';
import '../view_model/login_view_model.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ProductColor.instance.transparent,
      ),
      body: Padding(
        padding: const ProductPadding.loginPadding(),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: _buildForm(context),
        ),
      ),
    );
  }

  Widget _buildForm(BuildContext context) {
    return Form(
      key: context.watch<LoginViewModel>().formKey,
      child: Column(
        children: [
          const Padding(
            padding: ProductPadding.bottomHigh(),
            child: LabelLogo(),
          ),
          Padding(
            padding: const ProductPadding.bottomNormal(),
            child: CustomTextFormField(
              controller: context.watch<LoginViewModel>().emailController,
              hintText: LocaleStrings.emailTF.tr(),
              validator: (value) =>
                  LoginValidator.instance.emailValidator(value),
              isObscure: false,
              keyboardType: TextInputType.emailAddress,
            ),
          ),
          Padding(
            padding: const ProductPadding.bottomNormal(),
            child: CustomTextFormField(
              controller: context.watch<LoginViewModel>().passwordController,
              hintText: LocaleStrings.passTF.tr(),
              validator: (value) =>
                  LoginValidator.instance.passValidator(value),
              isObscure: true,
            ),
          ),
          Padding(
            padding: const ProductPadding.bottomNormal(),
            child: _buildFPButton(context),
          ),
          Padding(
            padding: const ProductPadding.bottomNormal(),
            child: _buildLoginButton(context),
          ),
          Padding(
            padding: const ProductPadding.bottomNormal(),
            child: _buildSignUpButton(context),
          )
        ],
      ),
    );
  }

  Widget _buildSignUpButton(BuildContext context) {
    return SizedBox(
      width: context.sized.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            LocaleStrings.haveAnAccount.tr(),
            style: context.general.textTheme.bodyMedium!.copyWith(
                color: context.watch<ThemeNotifier>().isLightTheme
                    ? ProductColor.instance.grey800
                    : ProductColor.instance.grey600),
          ),
          TextButton(
              onPressed: () {
                Navigator.pushNamed(context, Routes.SIGNUP);
              },
              child: Text(LocaleStrings.signUpBtn.tr()))
        ],
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return Consumer<LoginViewModel>(
      builder: (context, viewModel, _) {
        return SizedBox(
            width: context.sized.width,
            child: FilledButton(
                onPressed: viewModel.isLoading
                    ? null
                    : () {
                        context.read<LoginViewModel>().login(context);
                      },
                child: Text(LocaleStrings.loginBtn.tr())));
      },
    );
  }

  Widget _buildFPButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
            onPressed: () {
              context.read<ThemeNotifier>().changeTheme();
            },
            child: Text(LocaleStrings.forgetPassTxt.tr()))
      ],
    );
  }
}
