import 'package:flower/config/routes/routes.dart';
import 'package:flower/core/localization_constants/auth_constants.dart';
import 'package:flower/core/theme/app_colors.dart';
import 'package:flower/core/theme/app_text_style.dart';
import 'package:flower/core/theme/font_size_manager.dart';
import 'package:flower/core/utils/app_validator.dart';
import 'package:flower/core/widgets/app_sizebox.dart';
import 'package:flower/features/auth/presentation/login/cubit/login_cubit.dart';
import 'package:flower/features/auth/presentation/login/cubit/login_event.dart';
import 'package:flower/features/auth/presentation/login/widgets/custom_auth_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.emailFocus,
    required this.passwordFocus,
  });

  final GlobalKey<FormState> formKey;

  final TextEditingController emailController;
  final TextEditingController passwordController;

  final FocusNode emailFocus;
  final FocusNode passwordFocus;

  @override
  Widget build(BuildContext context) {
    final vm = context.read<LoginCubit>();

    return Form(
      key: formKey,
      child: Column(
        children: [
          CustomAuthTextField(
            label: context.email,
            hint: context.enterEmail,
            controller: emailController,
            focusNode: emailFocus,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            prefixIcon: Icons.email_outlined,
            validator: (value) => AppValidator.email(value),
          ),

          const AppSizedBox(height: 16),

          CustomAuthTextField(
            label: context.password,
            hint: context.enterPassword,
            controller: passwordController,
            focusNode: passwordFocus,
            keyboardType: TextInputType.visiblePassword,
            textInputAction: TextInputAction.done,
            isPassword: true,
            prefixIcon: Icons.lock_outline_rounded,
            validator: (value) => AppValidator.password(value),
          ),

          const AppSizedBox(height: 10),

          BlocBuilder<LoginCubit, LoginState>(
            builder: (context, state) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      vm.doEvent(RememberMeChanged(!state.rememberMe));
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 22,
                          height: 22,
                          child: Checkbox(
                            value: state.rememberMe,
                            activeColor: AppColors.primary,
                            side: BorderSide(
                              color: AppColors.grey700.withOpacity(0.35),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            onChanged: (value) {
                              if (value != null) {
                                vm.doEvent(RememberMeChanged(value));
                              }
                            },
                          ),
                        ),

                        const AppSizedBox(width: 5),

                        Text(
                          context.rememberMe,
                          style: getRegularStyle(
                            context: context,
                            fontSize: FontSizeManager.s12,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),

                  InkWell(
                    borderRadius: BorderRadius.circular(6),
                    onTap: () {
                      Navigator.pushNamed(context, Routes.forgetPassword);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 2,
                      ),
                      child: Text(
                        context.forgotPassword,
                        style: getTextWithLine(context: context),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
