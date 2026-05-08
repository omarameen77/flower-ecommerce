import 'package:flower/core/localization_constants/auth_constants.dart';
import 'package:flower/core/theme/app_colors.dart';
import 'package:flower/core/theme/app_text_style.dart';
import 'package:flower/core/widgets/app_sizebox.dart';
import 'package:flower/core/widgets/primary_button.dart';
import 'package:flower/features/auth/login/ui/cubit/login_intint.dart';
import 'package:flower/features/auth/login/ui/cubit/login_state.dart';
import 'package:flower/features/auth/login/ui/cubit/login_view_model.dart';
import 'package:flower/features/auth/login/ui/widgets/login_text_fields_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final vm = context.read<LoginViewModel>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const AppSizedBox(height: 30),

            /// fields
            const LoginTextFields(),

            const AppSizedBox(height: 12),

            /// remember me + forgot
            BlocBuilder<LoginViewModel, LoginState>(
              builder: (context, state) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: state.rememberMe,
                          onChanged: (value) {
                            vm.doIntent(RememberMeChanged(value!));
                          },
                        ),
                        Text(
                          context.rememberMe,
                          style: getRegularStyle(
                            context: context,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),

                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        context.forgotPassword,
                        style: getTextWithLine(context),
                      ),
                    ),
                  ],
                );
              },
            ),

            const AppSizedBox(height: 30),

            /// LOGIN BUTTON
            BlocBuilder<LoginViewModel, LoginState>(
              builder: (context, state) {
                return PrimaryButton(
                  text: context.login,
                  onTap: state.isFormValid
                      ? () {
                          if (_formKey.currentState!.validate()) {
                            vm.doIntent(LoginPressed());
                          }
                        }
                      : () {},
                );
              },
            ),

            const AppSizedBox(height: 16),

            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: Text("Continue as guest"),
            ),

            const SizedBox(height: 20),

            /// signup
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  context.dontHaveAccount,
                  style: getRegularStyle(
                    context: context,
                    color: AppColors.textPrimary,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    context.signUp,
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 16,
                      decoration: TextDecoration.underline,decorationColor: AppColors.primary
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}