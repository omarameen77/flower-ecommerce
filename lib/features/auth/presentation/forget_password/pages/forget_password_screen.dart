import 'package:flower/config/dependency_injection/di.dart';
import 'package:flower/config/routes/routes.dart';
import 'package:flower/core/theme/app_colors.dart';
import 'package:flower/core/widgets/app_sizebox.dart';
import 'package:flower/features/auth/presentation/forget_password/cubit/forget_password_cubit.dart';
import 'package:flower/features/auth/presentation/forget_password/cubit/forget_password_intents.dart';
import 'package:flower/features/auth/presentation/forget_password/widgets/forget_password_email_step.dart';
import 'package:flower/features/auth/presentation/forget_password/widgets/forget_password_otp_step.dart';
import 'package:flower/features/auth/presentation/forget_password/widgets/forget_password_reset_step.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final PageController _pageController = PageController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _otpController = TextEditingController();

  final TextEditingController _newPasswordController = TextEditingController();

  final TextEditingController _confirmPasswordController =
      TextEditingController();

  int _currentIndex = 0;

  void _nextPage() {
    if (_currentIndex < 2) {
      _currentIndex++;

      _pageController.animateToPage(
        _currentIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );

      setState(() {});
    }
  }

  @override
  void dispose() {
    _pageController.dispose();

    _emailController.dispose();
    _otpController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ForgetPasswordCubit>(),

      child: BlocListener<ForgetPasswordCubit, ForgetPasswordState>(
        listenWhen: (previous, current) =>
            previous.codeVerified != current.codeVerified,

        listener: (context, state) {
          if (state.codeVerified) {
            _nextPage();
          }
        },

        child: Scaffold(
          backgroundColor: AppColors.surface,

          body: Stack(
            children: [
              const Positioned.fill(
                child: ColoredBox(color: AppColors.surface),
              ),

              // Top left
              const Positioned(
                top: -50,
                left: -100,
                child: _AmbientGlow(size: 350, opacity: 0.10),
              ),

              // Top right
              Positioned(
                top: -90,
                right: -90,
                child: _AmbientGlow(
                  size: 280,
                  opacity: 0.085,
                  color: AppColors.primary,
                ),
              ),

              // Bottom right
              Positioned(
                bottom: -100,
                right: -100,
                child: _AmbientGlow(size: 320, opacity: 0.10),
              ),

              SafeArea(
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15, top: 12),
                        child: GestureDetector(
                          onTap: () => Navigator.pushReplacementNamed(
                            context,
                            Routes.login,
                          ),
                          child: const CircleAvatar(
                            radius: 17,
                            child: Icon(
                              Icons.arrow_back_ios_new_rounded,
                              size: 20,
                              color: AppColors.textWhite,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const AppSizedBox(height: 8),

                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: PageView(
                          controller: _pageController,
                          physics: const NeverScrollableScrollPhysics(),

                          children: [
                            ForgetPasswordEmailStep(
                              controller: _emailController,
                              onSubmit: () {
                                context.read<ForgetPasswordCubit>().doIntent(
                                  SubmitForgetPasswordIntent(
                                    _emailController.text.trim(),
                                  ),
                                );

                                _nextPage();
                              },
                            ),

                            BlocBuilder<
                              ForgetPasswordCubit,
                              ForgetPasswordState
                            >(
                              buildWhen: (previous, current) =>
                                  previous.isVerifyingCode !=
                                      current.isVerifyingCode ||
                                  previous.isCodeValid != current.isCodeValid ||
                                  previous.codeErrorMessage !=
                                      current.codeErrorMessage,

                              builder: (context, state) {
                                return ForgetPasswordOtpStep(
                                  controller: _otpController,

                                  isVerifyingCode: state.isVerifyingCode,

                                  isCodeValid: state.isCodeValid,

                                  errorMessage: state.codeErrorMessage,

                                  onSubmit: () {
                                    context
                                        .read<ForgetPasswordCubit>()
                                        .doIntent(
                                          VerifyResetCodeIntent(
                                            _otpController.text.trim(),
                                          ),
                                        );
                                  },
                                );
                              },
                            ),

                            ForgetPasswordResetStep(
                              newPasswordController: _newPasswordController,
                              confirmPasswordController:
                                  _confirmPasswordController,
                              onSubmit: () {
                                Navigator.pushReplacementNamed(
                                  context,
                                  Routes.login,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
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
