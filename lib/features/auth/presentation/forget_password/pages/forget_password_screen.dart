import 'package:flower/config/routes/routes.dart';
import 'package:flower/core/layout/app_padding.dart';
import 'package:flower/core/localization_constants/auth_constants.dart';
import 'package:flower/core/widgets/custom_app_bar.dart';
import 'package:flower/core/widgets/custom_snack_bar.dart';
import 'package:flower/features/auth/presentation/forget_password/cubit/forget_password_cubit.dart';
import 'package:flower/features/auth/presentation/forget_password/widgets/forget_password_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, title: context.password),
      body: BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
        listener: _onStateChanged,
        builder: (context, state) {
          final cubit = context.read<ForgetPasswordCubit>();
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
            child: ForgetPasswordForm(
              isLoading: state.isLoading,
              cubit: cubit,
            ),
          );
        },
      ),
    );
  }

  void _onStateChanged(BuildContext context, ForgetPasswordState state) {
    if (state.data != null) {
      final email = context.read<ForgetPasswordCubit>().emailController.text;
      Navigator.pushNamed(
        context,
        Routes.verificationCode,
        arguments: email.trim(),
      );
    } else if (state.errorMessage != null) {
      CustomSnackBar.error(context, state.errorMessage!);
    }
  }
}
