import 'package:flower/core/localization_constants/auth_constants.dart';
import 'package:flower/core/utils/app_validator.dart';
import 'package:flower/core/widgets/app_sizebox.dart';
import 'package:flower/features/auth/presentation/login/widgets/custom_auth_text_field.dart';
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // First Name
        CustomAuthTextField(
          controller: firstNameController,
          label: context.firstName,
          hint: context.enterFirstName,
          keyboardType: TextInputType.name,
          textInputAction: TextInputAction.next,
          prefixIcon: Icons.person_outline_rounded,
          validator: (value) => AppValidator.name(value),
        ),

        const AppSizedBox(height: 16),

        // Last Name
        CustomAuthTextField(
          controller: lastNameController,
          label: context.lastName,
          hint: context.enterLastName,
          keyboardType: TextInputType.name,
          textInputAction: TextInputAction.next,
          prefixIcon: Icons.person_outline_rounded,
          validator: (value) => AppValidator.name(value),
        ),

        const AppSizedBox(height: 16),

        // Email
        CustomAuthTextField(
          controller: emailController,
          label: context.email,
          hint: context.enterEmail,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          prefixIcon: Icons.email_outlined,
          autofillHints: const [AutofillHints.email],
          validator: (value) => AppValidator.email(value),
        ),

        const AppSizedBox(height: 16),

        // Phone
        CustomAuthTextField(
          controller: phoneController,
          label: context.phone,
          hint: context.enterPhoneNumber,
          keyboardType: TextInputType.phone,
          textInputAction: TextInputAction.next,
          prefixIcon: Icons.phone_outlined,
          autofillHints: const [AutofillHints.telephoneNumber],
          validator: (value) => AppValidator.phone(value),
        ),

        const AppSizedBox(height: 16),

        // Password + Confirm Password
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: CustomAuthTextField(
                controller: passwordController,
                label: context.password,
                hint: context.enterPassword,
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.next,
                //   prefixIcon: Icons.lock_outline_rounded,
                isPassword: true,
                validator: (value) => AppValidator.password(value),
              ),
            ),

            const AppSizedBox(width: 12),

            Expanded(
              child: CustomAuthTextField(
                controller: rePasswordController,
                label: context.confirmPassword,
                hint: context.confirmPassword,
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.done,
                // prefixIcon: Icons.lock_outline_rounded,
                isPassword: true,
                validator: (value) => AppValidator.confirmPassword(
                  value,
                  passwordController.text,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
