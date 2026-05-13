import 'package:easy_localization/easy_localization.dart';
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
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPasswordForm extends StatelessWidget {
  final String email;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final GlobalKey<FormState> formKey;

  const ResetPasswordForm({
    super.key,
    required this.email,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.formKey,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
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
              controller: passwordController,
              labelText: context.newPassword,
              hintText: context.enterNewPassword,
              isPassword: true,
              validator: (v) => AppValidator.password(v)?.tr(),
            ),
            const AppSizedBox(height: AppSize.s28),
            CustomTextField(
              controller: confirmPasswordController,
              labelText: context.confirmPassword,
              hintText: context.confirmPassword,
              isPassword: true,
              validator: (v) => AppValidator.confirmPassword(
                v,
                passwordController.text,
              )?.tr(),
            ),
            const AppSizedBox(height: AppSize.s50),
            BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
              buildWhen: (prev, curr) =>
                  prev.base.isLoading != curr.base.isLoading,
              builder: (context, state) {
                if (state.base.isLoading) return const ButtonLoadingWidget();
                return PrimaryButton(
                  text: context.confirm,
                  onTap: () {
                    if (formKey.currentState?.validate() ?? false) {
                      context.read<ResetPasswordCubit>().doIntent(
                        SubmitResetPasswordIntent(
                          email: email,
                          newPassword: passwordController.text,
                        ),
                      );
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
