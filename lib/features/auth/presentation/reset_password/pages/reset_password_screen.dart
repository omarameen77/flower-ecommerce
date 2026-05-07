import 'package:flower/config/routes/routes.dart';
import 'package:flower/core/layout/app_padding.dart';
import 'package:flower/core/localization_constants/auth_constants.dart';
import 'package:flower/core/widgets/custom_appbar.dart';
import 'package:flower/core/widgets/custom_snack_bar.dart';
import 'package:flower/features/auth/presentation/reset_password/cubit/reset_password_cubit.dart';
import 'package:flower/features/auth/presentation/reset_password/widgets/reset_password_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key, required this.email});
  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: context.password),
      body: BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
        listener: _onStateChanged,
        builder: (context, state) => _buildBody(context, state),
      ),
    );
  }

  void _onStateChanged(BuildContext context, ResetPasswordState state) {
    if (state.data != null) {
      Navigator.pushNamedAndRemoveUntil(context, Routes.login, (_) => false);
    } else if (state.errorMessage != null) {
      CustomSnackBar.error(context, state.errorMessage!);
    }
  }

  Widget _buildBody(BuildContext context, ResetPasswordState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
      child: ResetPasswordForm(
        email: email,
        cubit: context.read<ResetPasswordCubit>(),
        state: state,
      ),
    );
  }
}
