import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../core/theme/theme_notifier.dart';
import '../view_model/signup_view_model.dart';
import '../../../product/extension/image_extension.dart';
import 'package:provider/provider.dart';
import '../../../core/lang/locale_strings.dart';
import '../validator/signup_validator.dart';
import '../../../product/constant/product_color.dart';
import '../../../product/constant/product_padding.dart';
import '../../../product/widget/logo/label_logo.dart';
import '../../../product/widget/text_form_field/custom_text_form_field.dart';
import 'package:kartal/kartal.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: ProductColor.instance.transparent),
      body: Padding(
        padding: const ProductPadding.loginPadding(),
        child: _buildForm(context),
      ),
    );
  }

  Widget _buildForm(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Form(
          key: context.watch<SignupViewModel>().formKey,
          child: Column(
            children: [
              const Padding(
                padding: ProductPadding.bottomNormal(),
                child: LabelLogo(),
              ),
              Padding(
                padding: const ProductPadding.bottomNormal(),
                child: _buildProfileImagePicker(context),
              ),
              Padding(
                padding: const ProductPadding.bottomNormal(),
                child: CustomTextFormField(
                    controller:
                        context.watch<SignupViewModel>().emailController,
                    hintText: LocaleStrings.emailTF.tr(),
                    validator: (value) =>
                        SignupValidator.instance.emailValidator(value),
                    keyboardType: TextInputType.emailAddress,
                    isObscure: false),
              ),
              Padding(
                padding: const ProductPadding.bottomNormal(),
                child: CustomTextFormField(
                    controller:
                        context.watch<SignupViewModel>().usernameController,
                    hintText: LocaleStrings.usernameTF.tr(),
                    validator: (value) =>
                        SignupValidator.instance.usernameValidator(value),
                    isObscure: false),
              ),
              Padding(
                padding: const ProductPadding.bottomNormal(),
                child: CustomTextFormField(
                    controller: context.watch<SignupViewModel>().bioController,
                    hintText: LocaleStrings.bioTF.tr(),
                    validator: (value) =>
                        SignupValidator.instance.bioValidator(value),
                    isObscure: false),
              ),
              Padding(
                padding: const ProductPadding.bottomNormal(),
                child: CustomTextFormField(
                    controller:
                        context.watch<SignupViewModel>().passwordController,
                    hintText: LocaleStrings.passTF.tr(),
                    validator: (value) =>
                        SignupValidator.instance.passValidator(value),
                    isObscure: true),
              ),
              Padding(
                padding: const ProductPadding.bottomNormal(),
                child: CustomTextFormField(
                    controller: context
                        .watch<SignupViewModel>()
                        .passwordConfirmController,
                    hintText: LocaleStrings.passConfirmTF.tr(),
                    validator: (value) => SignupValidator.instance
                        .passConfirmValidator(
                            value: value,
                            pass: context
                                .read<SignupViewModel>()
                                .passwordController
                                .text),
                    isObscure: true),
              ),
              _buildSignupButton(context)
            ],
          )),
    );
  }

  Widget _buildProfileImagePicker(BuildContext context) {
    return Consumer<SignupViewModel>(
      builder: (context, viewModel, _) {
        return InkWell(
          onTap: () async {
            await viewModel.imageUpload();
          },
          child: CircleAvatar(
            radius: context.sized.dynamicWidth(0.15),
            backgroundColor: ProductColor.instance.transparent,
            child: viewModel.imageFile == null
                ? Image.asset(
                    ImagePNGs.default_user.path,
                    color: context.watch<ThemeNotifier>().isLightTheme
                        ? ProductColor.instance.black
                        : ProductColor.instance.white,
                  )
                : Image.file(
                    viewModel.imageFile!,
                    fit: BoxFit.cover,
                  ),
          ),
        );
      },
    );
  }

  Widget _buildSignupButton(BuildContext context) {
    return Consumer<SignupViewModel>(
      builder: (context, viewModel, _) {
        return SizedBox(
            width: context.sized.width,
            child: FilledButton(
                onPressed: viewModel.isLoading
                    ? null
                    : () async {
                        context.read<SignupViewModel>().signup(context);
                      },
                child: Text(LocaleStrings.signUpBtn.tr())));
      },
    );
  }
}
