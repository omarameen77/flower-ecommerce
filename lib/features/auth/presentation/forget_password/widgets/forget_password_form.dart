import 'package:flower/core/layout/app_size.dart';
import 'package:flower/core/localization_constants/auth_constants.dart';
import 'package:flower/core/utils/app_validator.dart';
import 'package:flower/core/widgets/app_sizebox.dart';
import 'package:flower/core/widgets/auth_header.dart';
import 'package:flower/core/widgets/button_loading_widget.dart';
import 'package:flower/core/widgets/custom_text_field.dart';
import 'package:flower/core/widgets/primary_button.dart';
import 'package:flower/features/auth/presentation/forget_password/cubit/forget_password_cubit.dart';
import 'package:flower/features/auth/presentation/forget_password/cubit/forget_password_intents.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgetPasswordForm extends StatelessWidget {
  final TextEditingController emailController;
  final GlobalKey<FormState> formKey;

  const ForgetPasswordForm({
    super.key,
    required this.emailController,
    required this.formKey,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
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
            controller: emailController,
            labelText: context.email,
            hintText: context.enterEmail,
            keyboardType: TextInputType.emailAddress,
            validator: (v) => AppValidator.email(context, v),
          ),
          const AppSizedBox(height: AppSize.s50),
          BlocBuilder<ForgetPasswordCubit, ForgetPasswordState>(
            buildWhen: (prev, curr) =>
                prev.base.isLoading != curr.base.isLoading,
            builder: (context, state) {
              if (state.base.isLoading) return const ButtonLoadingWidget();
              return PrimaryButton(
                text: context.confirm,
                onTap: () {
                  if (formKey.currentState?.validate() ?? false) {
                    context.read<ForgetPasswordCubit>().doIntent(
                      SubmitForgetPasswordIntent(emailController.text.trim()),
                    );
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
