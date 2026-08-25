import 'package:flower/config/dependency_injection/di.dart';
import 'package:flower/config/routes/routes.dart';
import 'package:flower/core/localization_constants/auth_constants.dart';
import 'package:flower/core/localization_constants/error_massage_constants.dart';
import 'package:flower/core/theme/app_colors.dart';
import 'package:flower/core/widgets/app_sizebox.dart';
import 'package:flower/core/widgets/button_loading_widget.dart';
import 'package:flower/core/widgets/custom_snack_bar.dart';
import 'package:flower/core/widgets/primary_button.dart';
import 'package:flower/features/auth/presentation/login/widgets/auth_header.dart';
import 'package:flower/features/auth/presentation/register/cubit/register_cubit.dart';
import 'package:flower/features/auth/presentation/register/cubit/register_event.dart';
import 'package:flower/features/auth/presentation/register/widgets/already_have_account_widget.dart';
import 'package:flower/features/auth/presentation/register/widgets/gender_selection_widget.dart';
import 'package:flower/features/auth/presentation/register/widgets/register_text_fields_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController rePasswordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    rePasswordController.dispose();
    phoneController.dispose();

    super.dispose();
  }

  void _register(BuildContext context) {
    context.read<RegisterCubit>().doEvent(
      Register(
        firstName: firstNameController.text.trim(),
        lastName: lastNameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        rePassword: rePasswordController.text.trim(),
        phone: phoneController.text.trim(),
        gender: context.read<RegisterCubit>().state.selectedGender,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<RegisterCubit>(),
      child: BlocListener<RegisterCubit, RegisterState>(
        listenWhen: (previous, current) =>
            previous.registerState != current.registerState,
        listener: (context, state) {
          if (state.registerState.errorMessage != null) {
            CustomSnackBar.error(context, state.registerState.errorMessage!);
          } else if (state.registerState.data != null) {
            CustomSnackBar.success(context, ErrorConstants.signupSuccessfully);

            Navigator.pushReplacementNamed(context, Routes.login);
          }
        },
        child: Scaffold(
          backgroundColor: AppColors.surface,
          body: Stack(
            children: [
              const Positioned.fill(
                child: ColoredBox(color: AppColors.surface),
              ),

              SafeArea(
                child: _RegisterView(
                  formKey: _formKey,
                  firstNameController: firstNameController,
                  lastNameController: lastNameController,
                  emailController: emailController,
                  passwordController: passwordController,
                  rePasswordController: rePasswordController,
                  phoneController: phoneController,
                  onRegister: _register,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RegisterView extends StatelessWidget {
  const _RegisterView({
    required this.formKey,
    required this.firstNameController,
    required this.lastNameController,
    required this.emailController,
    required this.passwordController,
    required this.rePasswordController,
    required this.phoneController,
    required this.onRegister,
  });

  final GlobalKey<FormState> formKey;

  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController rePasswordController;
  final TextEditingController phoneController;

  final void Function(BuildContext) onRegister;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      behavior: HitTestBehavior.opaque,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                    child: AuthHeader(
                      title: context.createAccountTitle,
                      subtitle: context.createAccountSubtitle,
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
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          RegisterTextFieldsWidget(
                            firstNameController: firstNameController,
                            lastNameController: lastNameController,
                            emailController: emailController,
                            passwordController: passwordController,
                            rePasswordController: rePasswordController,
                            phoneController: phoneController,
                          ),

                          const AppSizedBox(height: 18),
                          const GenderSelectionWidget(),
                          const AppSizedBox(height: 20),

                          BlocBuilder<RegisterCubit, RegisterState>(
                            builder: (context, state) {
                              if (state.registerState.isLoading) {
                                return const ButtonLoadingWidget();
                              }

                              return PrimaryButton(
                                text: context.signUp,
                                onTap: () {
                                  if (!(formKey.currentState?.validate() ??
                                      false)) {
                                    return;
                                  }

                                  final gender = context
                                      .read<RegisterCubit>()
                                      .state
                                      .selectedGender;

                                  if (gender.isEmpty) {
                                    return;
                                  }

                                  onRegister(context);
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),

                  const AppSizedBox(height: 15),

                  Center(
                    child: AlreadyHaveAccountWidget(
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
