import 'package:flower/config/dependency_injection/di.dart';
import 'package:flower/config/routes/routes.dart';
import 'package:flower/core/localization_constants/auth_constants.dart';
import 'package:flower/core/localization_constants/error_massage_constants.dart';
import 'package:flower/core/theme/app_colors.dart';
import 'package:flower/core/widgets/custom_appbar.dart';
import 'package:flower/core/widgets/custom_snack_bar.dart';
import 'package:flower/features/auth/presentation/login/cubit/login_cubit.dart';
import 'package:flower/features/auth/presentation/login/widgets/login_forms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<LoginCubit>(),
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: CustomAppBar(title: context.login, buttonEnable: false),
        body: BlocListener<LoginCubit, LoginState>(
          listener: (context, state) {
            final loginData = state.loginState.data;

            if (loginData != null) {
              CustomSnackBar.success(context, ErrorConstants.loginSuccessfully);
              Navigator.pushReplacementNamed(context, Routes.appSections);
            }

            if (state.loginState.errorMessage != null) {
              CustomSnackBar.error(context, state.loginState.errorMessage!);
            }
          },
          child: const SingleChildScrollView(child: LoginForm()),
        ),
      ),
    );
  }
}
