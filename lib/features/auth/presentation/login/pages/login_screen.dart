import 'package:flower/config/dependency_injection/di.dart';
import 'package:flower/config/routes/routes.dart';
import 'package:flower/core/localization_constants/auth_constants.dart';
import 'package:flower/core/localization_constants/error_massage_constants.dart';
import 'package:flower/core/theme/app_colors.dart';
import 'package:flower/core/widgets/app_sizebox.dart';
import 'package:flower/core/widgets/button_loading_widget.dart';
import 'package:flower/core/widgets/custom_snack_bar.dart';
import 'package:flower/core/widgets/primary_button.dart';
import 'package:flower/features/auth/presentation/login/cubit/login_cubit.dart';
import 'package:flower/features/auth/presentation/login/cubit/login_event.dart';
import 'package:flower/features/auth/presentation/login/widgets/aurh_footer.dart';
import 'package:flower/features/auth/presentation/login/widgets/auth_header.dart';
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
        backgroundColor: AppColors.surface,
        body: Stack(
          children: [
            const Positioned.fill(child: ColoredBox(color: AppColors.surface)),

            const Positioned(
              top: -50,
              left: -100,
              child: _AmbientGlow(size: 350, opacity: 0.10),
            ),

            Positioned(
              top: -90,
              right: -90,
              child: _AmbientGlow(
                size: 280,
                opacity: 0.085,
                color: AppColors.primary,
              ),
            ),
            Positioned(
              bottom: -100,
              right: -100,
              child: _AmbientGlow(size: 320, opacity: 0.10),
            ),
            SafeArea(child: _LoginView()),
          ],
        ),
      ),
    );
  }
}

class _AmbientGlow extends StatelessWidget {
  const _AmbientGlow({
    required this.size,
    required this.opacity,
    this.color = AppColors.primary,
  });

  final double size;
  final double opacity;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            center: Alignment.center,
            radius: 0.72,
            colors: [
              color.withOpacity(opacity),
              color.withOpacity(opacity * 0.75),
              color.withOpacity(opacity * 0.25),
              color.withOpacity(0),
            ],
            stops: const [0.0, 0.35, 0.68, 1.0],
          ),
        ),
      ),
    );
  }
}

class _LoginView extends StatefulWidget {
  const _LoginView();

  @override
  State<_LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<_LoginView> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    _emailFocus.dispose();
    _passwordFocus.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.read<LoginCubit>();

    return BlocListener<LoginCubit, LoginState>(
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
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        behavior: HitTestBehavior.opaque,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight - 48,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: const AuthHeader(
                        title: 'Welcome Back',
                        subtitle: 'Log in to continue to your account',
                      ),
                    ),

                    const AppSizedBox(height: 24),

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(18, 20, 18, 18),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(22),
                        border: Border.all(
                          color: AppColors.grey700.withOpacity(0.08),
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primaryLight.withOpacity(0.055),
                            blurRadius: 30,
                            spreadRadius: 5,
                            offset: const Offset(0, 8),
                          ),
                          BoxShadow(
                            color: AppColors.primary.withOpacity(0.020),
                            blurRadius: 20,
                            spreadRadius: 2,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          LoginForm(
                            formKey: _formKey,
                            emailController: _emailController,
                            passwordController: _passwordController,
                            emailFocus: _emailFocus,
                            passwordFocus: _passwordFocus,
                          ),

                          const AppSizedBox(height: 18),

                          BlocBuilder<LoginCubit, LoginState>(
                            builder: (context, state) {
                              if (state.loginState.isLoading) {
                                return const ButtonLoadingWidget();
                              }

                              return PrimaryButton(
                                text: context.login,
                                onTap: () {
                                  if (_formKey.currentState?.validate() ??
                                      false) {
                                    vm.doEvent(
                                      Login(
                                        email: _emailController.text.trim(),
                                        password: _passwordController.text
                                            .trim(),
                                      ),
                                    );
                                  }
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    const AppSizedBox(height: 22),
                    AuthFooter(
                      question: context.dontHaveAccount,
                      actionLabel: context.signUp,
                      onActionTap: () {
                        Navigator.pushNamed(context, Routes.signup);
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
