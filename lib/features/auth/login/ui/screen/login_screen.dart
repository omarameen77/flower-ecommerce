import 'package:flower/config/dependency_injection/di.dart';
import 'package:flower/core/localization_constants/auth_constants.dart';
import 'package:flower/core/theme/app_colors.dart';
import 'package:flower/features/auth/login/ui/cubit/login_state.dart';
import 'package:flower/features/auth/login/ui/cubit/login_view_model.dart';
import 'package:flower/features/auth/login/ui/widgets/login_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<LoginViewModel>(),
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: Text(context.login),
          backgroundColor: AppColors.background,
          elevation: 0,
        ),
        body: BlocListener<LoginViewModel, LoginState>(
          listener: (context, state) {
            if (state.user != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Login Success")),
              );
            }

            if (state.errorMessage != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errorMessage!)),
              );
            }
          },
          child: const SingleChildScrollView(
            child: LoginForm(),
          ),
        ),
      ),
    );
  }
}