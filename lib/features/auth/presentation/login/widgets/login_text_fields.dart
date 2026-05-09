import 'package:flower/core/localization_constants/auth_constants.dart';
import 'package:flower/core/utils/app_validator.dart';
import 'package:flower/core/widgets/app_sizebox.dart';
import 'package:flower/core/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class LoginTextFields extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  const LoginTextFields({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  @override
  State<LoginTextFields> createState() => _LoginTextFieldsState();
}

class _LoginTextFieldsState extends State<LoginTextFields> {
  final bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextField(
          controller: widget.emailController,
          labelText: context.email,
          hintText: context.enterEmail,
          keyboardType: TextInputType.emailAddress,
          validator: (value) => AppValidator.email(value),
        ),

        const AppSizedBox(height: 25),

        CustomTextField(
          controller: widget.passwordController,
          labelText: context.password,
          hintText: context.enterPassword,
          isPassword: !_isPasswordVisible,
          validator: (value) => AppValidator.password(value),
        ),
      ],
    );
  }
}
