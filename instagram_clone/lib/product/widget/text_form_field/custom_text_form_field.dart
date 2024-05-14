import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/theme_notifier.dart';
import '../../constant/product_box_decoration.dart';
import '../../constant/product_color.dart';
import '../../constant/product_input_decoration.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    required TextEditingController controller,
    required String hintText,
    required String? Function(String?) validator,
    required bool isObscure,
    TextInputType? keyboardType,
    super.key,
  })  : _controller = controller,
        _hintText = hintText,
        _validator = validator,
        _isObscure = isObscure,
        _keyboardType = keyboardType;

  final TextEditingController _controller;
  final String _hintText;
  final String? Function(String?) _validator;
  final TextInputType? _keyboardType;
  final bool _isObscure;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ProductBoxDecoration.loginTF(context),
      child: TextFormField(
        obscureText: _isObscure,
        obscuringCharacter: "*",
        style: context.general.textTheme.bodyLarge!.copyWith(
          color: context.watch<ThemeNotifier>().isLightTheme
              ? ProductColor.instance.black
              : ProductColor.instance.white,
        ),
        decoration: ProductInputDecoration.loginTF(context, _hintText),
        validator: (value) => _validator(value),
        controller: _controller,
        keyboardType: _keyboardType,
      ),
    );
  }
}
