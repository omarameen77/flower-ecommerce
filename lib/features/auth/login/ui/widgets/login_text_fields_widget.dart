import 'package:flower/core/localization_constants/auth_constants.dart';
import 'package:flower/core/utils/app_validator.dart';
import 'package:flower/core/widgets/app_sizebox.dart';
import 'package:flower/core/widgets/custom_text_field.dart';
import 'package:flower/features/auth/login/ui/cubit/login_intint.dart';
import 'package:flower/features/auth/login/ui/cubit/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class LoginTextFields extends StatefulWidget {
  const LoginTextFields({super.key});

  @override
  State<LoginTextFields> createState() => _LoginTextFieldsState();
}

class _LoginTextFieldsState extends State<LoginTextFields> {
  bool _isPasswordVisible = false;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final vm = context.read<LoginViewModel>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextField(
          controller: emailController,
          labelText: context.email,
          hintText: context.enterEmail,
          keyboardType: TextInputType.emailAddress,
          validator: (value) => AppValidator.email(context, value),
          onChanged: (value) {
            vm.doIntent(EmailChanged(value));
          },
        ),

        const AppSizedBox(height: 25),

        CustomTextField(
          controller: passwordController,
          labelText: context.password,
          hintText: context.enterPassword,
          isPassword: !_isPasswordVisible,
          validator: (value) => AppValidator.password(context, value),
          onChanged: (value) {
            vm.doIntent(PasswordChanged(value));
          },
        ),
      ],
    );
  }
}