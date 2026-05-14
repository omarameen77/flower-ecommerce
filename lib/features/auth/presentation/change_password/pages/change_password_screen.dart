import 'package:easy_localization/easy_localization.dart';
import 'package:flower/core/layout/app_padding.dart';
import 'package:flower/core/localization_constants/auth_constants.dart';
import 'package:flower/core/widgets/custom_appbar.dart';
import 'package:flower/core/widgets/custom_snack_bar.dart';
import 'package:flower/features/auth/presentation/change_password/cubit/change_password_cubit.dart';
import 'package:flower/features/auth/presentation/change_password/widgets/change_password_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: context.resetPassword),
      body: BlocListener<ChangePasswordCubit, ChangePasswordState>(
        listener: _onStateChanged,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
          child: ChangePasswordForm(
            currentPasswordController: _currentPasswordController,
            newPasswordController: _newPasswordController,
            confirmPasswordController: _confirmPasswordController,
            formKey: _formKey,
          ),
        ),
      ),
    );
  }

  void _onStateChanged(BuildContext context, ChangePasswordState state) {
    if (state.base.data != null) {
      CustomSnackBar.success(context, context.passwordChangedSuccess);
      Navigator.pop(context);
    } else if (state.base.errorMessage != null) {
      CustomSnackBar.error(context, state.base.errorMessage!.tr());
    }
  }
}
