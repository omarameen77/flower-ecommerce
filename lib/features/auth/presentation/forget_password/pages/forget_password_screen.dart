import 'package:easy_localization/easy_localization.dart';
import 'package:flower/config/routes/routes.dart';
import 'package:flower/core/layout/app_padding.dart';
import 'package:flower/core/localization_constants/auth_constants.dart';
import 'package:flower/core/widgets/custom_appbar.dart';
import 'package:flower/core/widgets/custom_snack_bar.dart';
import 'package:flower/features/auth/presentation/forget_password/cubit/forget_password_cubit.dart';
import 'package:flower/features/auth/presentation/forget_password/widgets/forget_password_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: context.password),
      body: BlocListener<ForgetPasswordCubit, ForgetPasswordState>(
        listener: _onStateChanged,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
          child: ForgetPasswordForm(
            emailController: _emailController,
            formKey: _formKey,
          ),
        ),
      ),
    );
  }

  void _onStateChanged(BuildContext context, ForgetPasswordState state) {
    if (state.base.data != null) {
      Navigator.pushNamed(
        context,
        Routes.verificationCode,
        arguments: state.email,
      );
    } else if (state.base.errorMessage != null) {
      CustomSnackBar.error(context, state.base.errorMessage!.tr());
    }
  }
}
