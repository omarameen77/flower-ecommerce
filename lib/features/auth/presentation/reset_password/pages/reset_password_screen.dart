import 'package:easy_localization/easy_localization.dart';
import 'package:flower/config/routes/routes.dart';
import 'package:flower/core/layout/app_padding.dart';
import 'package:flower/core/localization_constants/auth_constants.dart';
import 'package:flower/core/widgets/custom_appbar.dart';
import 'package:flower/core/widgets/custom_snack_bar.dart';
import 'package:flower/features/auth/presentation/reset_password/cubit/reset_password_cubit.dart';
import 'package:flower/features/auth/presentation/reset_password/widgets/reset_password_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key, required this.email});
  final String email;

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: context.password),
      body: BlocListener<ResetPasswordCubit, ResetPasswordState>(
        listener: _onStateChanged,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
          child: ResetPasswordForm(
            email: widget.email,
            passwordController: _passwordController,
            confirmPasswordController: _confirmPasswordController,
            formKey: _formKey,
          ),
        ),
      ),
    );
  }

  void _onStateChanged(BuildContext context, ResetPasswordState state) {
    if (state.base.data != null) {
      Navigator.pushNamedAndRemoveUntil(context, Routes.login, (_) => false);
    } else if (state.base.errorMessage != null) {
      CustomSnackBar.error(context, state.base.errorMessage!.tr());
    }
  }
}
