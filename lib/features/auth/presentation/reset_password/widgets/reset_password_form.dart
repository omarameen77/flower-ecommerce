import 'package:flower/core/layout/app_size.dart';
import 'package:flower/core/localization_constants/auth_constants.dart';
import 'package:flower/core/utils/app_validator.dart';
import 'package:flower/core/widgets/app_sizebox.dart';
import 'package:flower/core/widgets/auth_header.dart';
import 'package:flower/core/widgets/primary_button.dart';
import 'package:flower/features/auth/presentation/reset_password/view_model/reset_password_cubit.dart';
import 'package:flower/features/auth/presentation/reset_password/view_model/reset_password_state.dart';
import 'package:flower/features/auth/presentation/reset_password/widgets/password_field.dart';
import 'package:flutter/material.dart';

class ResetPasswordForm extends StatelessWidget {
  final String email;
  final ResetPasswordCubit cubit;
  final ResetPasswordState state;

  const ResetPasswordForm({
    super.key,
    required this.email,
    required this.cubit,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: cubit.formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const AppSizedBox(height: AppSize.s28),
            AuthHeader(
              title: context.resetPassword,
              subtitle: context.resetPasswordCondition,
            ),
            const AppSizedBox(height: AppSize.s28),
            _buildPasswordField(context),
            const AppSizedBox(height: AppSize.s28),
            _buildConfirmField(context),
            const AppSizedBox(height: AppSize.s50),
            _buildSubmit(context),
          ],
        ),
      ),
    );
  }

  Widget _buildPasswordField(BuildContext context) {
    return PasswordField(
      controller: cubit.passwordController,
      label: context.newPassword,
      hint: context.enterNewPassword,
      isObscure: state.isObscurePassword,
      onToggle: cubit.togglePasswordVisibility,
      validator: (v) => AppValidator.password(context, v),
    );
  }

  Widget _buildConfirmField(BuildContext context) {
    return PasswordField(
      controller: cubit.confirmPasswordController,
      label: context.confirmPassword,
      hint: context.confirmPassword,
      isObscure: state.isObscureConfirm,
      onToggle: cubit.toggleConfirmVisibility,
      validator: (v) => AppValidator.confirmPassword(
        context,
        v,
        cubit.passwordController.text,
      ),
    );
  }

  Widget _buildSubmit(BuildContext context) {
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    return PrimaryButton(
      text: context.confirm,
      onTap: () => cubit.submit(email: email),
    );
  }
}
