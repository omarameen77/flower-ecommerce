import 'package:flower/core/layout/app_size.dart';
import 'package:flower/core/localization_constants/auth_constants.dart';
import 'package:flower/core/utils/app_validator.dart';
import 'package:flower/core/widgets/app_sizebox.dart';
import 'package:flower/core/widgets/auth_header.dart';
import 'package:flower/core/widgets/button_loading_widget.dart';
import 'package:flower/core/widgets/custom_text_field.dart';
import 'package:flower/core/widgets/primary_button.dart';
import 'package:flower/features/auth/presentation/reset_password/cubit/reset_password_cubit.dart';
import 'package:flower/features/auth/presentation/reset_password/cubit/reset_password_intents.dart';
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
            CustomTextField(
              controller: cubit.passwordController,
              labelText: context.newPassword,
              hintText: context.enterNewPassword,
              isPassword: true,
              validator: (v) => AppValidator.password(context, v),
            ),
            const AppSizedBox(height: AppSize.s28),
            CustomTextField(
              controller: cubit.confirmPasswordController,
              labelText: context.confirmPassword,
              hintText: context.confirmPassword,
              isPassword: true,
              validator: (v) => AppValidator.confirmPassword(
                context,
                v,
                cubit.passwordController.text,
              ),
            ),
            const AppSizedBox(height: AppSize.s50),
            _buildSubmit(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSubmit(BuildContext context) {
    if (state.isLoading) return const ButtonLoadingWidget();
    return PrimaryButton(
      text: context.confirm,
      onTap: () {
        if (cubit.formKey.currentState?.validate() ?? false) {
          cubit.doIntent(SubmitResetPasswordIntent(email));
        }
      },
    );
  }
}
