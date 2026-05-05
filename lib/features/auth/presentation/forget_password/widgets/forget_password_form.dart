import 'package:flower/core/layout/app_size.dart';
import 'package:flower/core/localization_constants/auth_constants.dart';
import 'package:flower/core/utils/app_validator.dart';
import 'package:flower/core/widgets/app_sizebox.dart';
import 'package:flower/core/widgets/auth_header.dart';
import 'package:flower/core/widgets/custom_text_field.dart';
import 'package:flower/core/widgets/primary_button.dart';
import 'package:flower/features/auth/presentation/forget_password/view_model/forget_password_cubit.dart';
import 'package:flutter/material.dart';

class ForgetPasswordForm extends StatelessWidget {
  final bool isLoading;
  final ForgetPasswordCubit cubit;

  const ForgetPasswordForm({
    super.key,
    required this.isLoading,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: cubit.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const AppSizedBox(height: AppSize.s28),
          AuthHeader(
            title: context.forgetPasswordTitle,
            subtitle: context.forgetPasswordSubtitle,
          ),
          const AppSizedBox(height: AppSize.s28),
          CustomTextField(
            controller: cubit.emailController,
            labelText: context.email,
            hintText: context.enterEmail,
            keyboardType: TextInputType.emailAddress,
            validator: (v) => AppValidator.email(context, v),
          ),
          const AppSizedBox(height: AppSize.s50),
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : PrimaryButton(text: context.confirm, onTap: cubit.submit),
        ],
      ),
    );
  }
}
