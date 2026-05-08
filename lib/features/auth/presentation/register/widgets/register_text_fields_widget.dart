import 'package:flower/core/localization_constants/auth_constants.dart';
import 'package:flower/core/utils/app_validator.dart';
import 'package:flower/core/widgets/app_sizebox.dart';
import 'package:flower/core/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class RegisterTextFieldsWidget extends StatelessWidget {
  const RegisterTextFieldsWidget({
    super.key,
    required this.firstNameController,
    required this.lastNameController,
    required this.emailController,
    required this.passwordController,
    required this.rePasswordController,
    required this.phoneController,
  });

  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController rePasswordController;
  final TextEditingController phoneController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: CustomTextField(
                controller: firstNameController,
                hintText: context.enterFirstName,
                labelText: context.firstName,
                validator: (value) => AppValidator.name(value),
              ),
            ),
            AppSizedBox(width: 20),
            Expanded(
              child: CustomTextField(
                controller: lastNameController,
                hintText: context.enterLastName,
                labelText: context.lastName,
                validator: (value) => AppValidator.name(value),
              ),
            ),
          ],
        ),
        AppSizedBox(height: 20),

        CustomTextField(
          controller: emailController,
          hintText: context.enterEmail,
          labelText: context.email,
          validator: (value) => AppValidator.email(value),
        ),
        AppSizedBox(height: 20),

        Row(
          children: [
            Expanded(
              child: CustomTextField(
                controller: passwordController,
                hintText: context.enterPassword,
                labelText: context.password,
                isPassword: true,
                validator: (value) => AppValidator.password(value),
              ),
            ),
            AppSizedBox(width: 20),
            Expanded(
              child: CustomTextField(
                controller: rePasswordController,
                hintText: context.password,
                labelText: context.confirmPassword,
                isPassword: true,
                validator: (value) =>
                    AppValidator.confirmPassword(value, passwordController.text),
              ),
            ),
          ],
        ),
        AppSizedBox(height: 20),

        CustomTextField(
          controller: phoneController,
          hintText: context.enterPhoneNumber,
          labelText: context.phone,
          validator: (value) => AppValidator.phone(value),
        ),
      ],
    );
  }
}
