import 'package:easy_localization/easy_localization.dart';
import 'package:flower/core/layout/app_size.dart';
import 'package:flower/core/localization_constants/auth_constants.dart';
import 'package:flower/core/utils/app_validator.dart';
import 'package:flower/core/widgets/app_sizebox.dart';
import 'package:flower/core/widgets/button_loading_widget.dart';
import 'package:flower/core/widgets/custom_text_field.dart';
import 'package:flower/core/widgets/primary_button.dart';
import 'package:flower/features/auth/presentation/change_password/cubit/change_password_cubit.dart';
import 'package:flower/features/auth/presentation/change_password/cubit/change_password_intents.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePasswordForm extends StatelessWidget {
  final TextEditingController currentPasswordController;
  final TextEditingController newPasswordController;
  final TextEditingController confirmPasswordController;
  final GlobalKey<FormState> formKey;

  const ChangePasswordForm({
    super.key,
    required this.currentPasswordController,
    required this.newPasswordController,
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
            CustomTextField(
              controller: currentPasswordController,
              labelText: context.currentPassword,
              hintText: context.enterCurrentPassword,
              isPassword: true,
              validator: (v) => AppValidator.password(v)?.tr(),
            ),
            const AppSizedBox(height: AppSize.s20),
            CustomTextField(
              controller: newPasswordController,
              labelText: context.newPassword,
              hintText: context.enterNewPassword,
              isPassword: true,
              validator: (v) => AppValidator.newPassword(
                v,
                currentPasswordController.text,
              )?.tr(),
            ),
            const AppSizedBox(height: AppSize.s20),
            CustomTextField(
              controller: confirmPasswordController,
              labelText: context.confirmNewPassword,
              hintText: context.confirmNewPassword,
              isPassword: true,
              validator: (v) => AppValidator.confirmPassword(
                v,
                newPasswordController.text,
              )?.tr(),
            ),
            const AppSizedBox(height: AppSize.s50),
            BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
              buildWhen: (prev, curr) =>
                  prev.base.isLoading != curr.base.isLoading,
              builder: (context, state) {
                if (state.base.isLoading) return const ButtonLoadingWidget();
                return ListenableBuilder(
                  listenable: Listenable.merge([
                    currentPasswordController,
                    newPasswordController,
                    confirmPasswordController,
                  ]),
                  builder: (context, _) {
                    final allFilled =
                        currentPasswordController.text.trim().isNotEmpty &&
                        newPasswordController.text.trim().isNotEmpty &&
                        confirmPasswordController.text.trim().isNotEmpty;
                    return PrimaryButton(
                      text: context.update,
                      onTap: allFilled
                          ? () {
                              if (formKey.currentState?.validate() ?? false) {
                                context.read<ChangePasswordCubit>().doIntent(
                                  SubmitChangePasswordIntent(
                                    oldPassword:
                                        currentPasswordController.text,
                                    newPassword: newPasswordController.text,
                                  ),
                                );
                              }
                            }
                          : null,
                    );
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
