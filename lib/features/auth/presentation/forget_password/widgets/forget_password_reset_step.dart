import 'package:flower/core/resources/app_lotie.dart';
import 'package:flower/core/widgets/app_sizebox.dart';
import 'package:flower/core/widgets/primary_button.dart';
import 'package:flower/features/auth/presentation/login/widgets/auth_header.dart';
import 'package:flower/features/auth/presentation/login/widgets/custom_auth_text_field.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ForgetPasswordResetStep extends StatefulWidget {
  const ForgetPasswordResetStep({
    super.key,
    required this.newPasswordController,
    required this.confirmPasswordController,
    required this.onSubmit,
  });

  final TextEditingController newPasswordController;
  final TextEditingController confirmPasswordController;
  final VoidCallback onSubmit;

  @override
  State<ForgetPasswordResetStep> createState() =>
      _ForgetPasswordResetStepState();
}

class _ForgetPasswordResetStepState extends State<ForgetPasswordResetStep> {
  final _formKey = GlobalKey<FormState>();

  String? _passwordValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Password is required';
    }

    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }

    return null;
  }

  String? _confirmPasswordValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please confirm your password';
    }

    if (value != widget.newPasswordController.text) {
      return 'Passwords do not match';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const AuthHeader(
              title: 'Reset Password',
              subtitle: 'Create a new password for your account',
            ),

            const AppSizedBox(height: 30),

            SizedBox(
              height: 190,
              width: 190,
              child: Lottie.asset(
                AppLotie.lottieReset,
                repeat: false,
                fit: BoxFit.contain,
              ),
            ),

            const AppSizedBox(height: 25),

            CustomAuthTextField(
              label: 'New Password',
              hint: 'Enter your new password',
              controller: widget.newPasswordController,
              keyboardType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.next,
              isPassword: true,
              prefixIcon: Icons.lock_outline_rounded,
              validator: _passwordValidator,
            ),

            const AppSizedBox(height: 20),

            CustomAuthTextField(
              label: 'Confirm Password',
              hint: 'Re-enter your password',
              controller: widget.confirmPasswordController,
              keyboardType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.done,
              isPassword: true,
              prefixIcon: Icons.lock_outline_rounded,
              validator: _confirmPasswordValidator,
            ),

            const AppSizedBox(height: 28),

            SizedBox(
              width: double.infinity,
              child: PrimaryButton(
                text: 'Continue',
                onTap: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    widget.onSubmit();
                  }
                },
              ),
            ),

            const AppSizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
