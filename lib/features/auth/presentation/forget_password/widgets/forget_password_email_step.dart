import 'package:flower/core/localization_constants/auth_constants.dart';
import 'package:flower/core/localization_constants/validation_constants.dart';
import 'package:flower/core/resources/app_lotie.dart';
import 'package:flower/core/widgets/app_sizebox.dart';
import 'package:flower/core/widgets/primary_button.dart';
import 'package:flower/features/auth/presentation/login/widgets/auth_header.dart';
import 'package:flower/features/auth/presentation/login/widgets/custom_auth_text_field.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ForgetPasswordEmailStep extends StatelessWidget {
  const ForgetPasswordEmailStep({
    super.key,
    required this.controller,
    required this.onSubmit,
  });

  final TextEditingController controller;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Column(
              children: [
                AuthHeader(
                  title: context.forgetPasswordTitle,
                  subtitle: context.forgetPasswordSubtitle,
                ),

                const AppSizedBox(height: 45),
                SizedBox(
                  height: 190,
                  width: 190,
                  child: Lottie.asset(AppLotie.lottieMail, fit: BoxFit.contain),
                ),

                const AppSizedBox(height: 30),

                CustomAuthTextField(
                  label: context.email,
                  hint: context.enterEmail,
                  controller: controller,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                  prefixIcon: Icons.email_outlined,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return context.requiredField;
                    }

                    if (!value.contains('@')) {
                      return ValidationConstants.invalidEmail;
                    }

                    return null;
                  },
                ),

                const AppSizedBox(height: 28),

                SizedBox(
                  width: double.infinity,
                  child: PrimaryButton(text: context.sendCode, onTap: onSubmit),
                ),

                const AppSizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }
}
