import 'package:flower/config/routes/routes.dart';
import 'package:flower/core/localization_constants/auth_constants.dart';
import 'package:flower/core/theme/app_colors.dart';
import 'package:flower/core/widgets/app_sizebox.dart';
import 'package:flower/core/widgets/custom_snack_bar.dart';
import 'package:flower/core/widgets/primary_button.dart';
import 'package:flower/core/widgets/button_loading_widget.dart';
import 'package:flower/features/auth/presentation/register/cubit/register_cubit.dart';
import 'package:flower/features/auth/presentation/register/cubit/register_event.dart';
import 'package:flower/features/auth/presentation/register/widgets/already_have_account_widget.dart';
import 'package:flower/features/auth/presentation/register/widgets/gender_selection_widget.dart';
import 'package:flower/features/auth/presentation/register/widgets/register_text_fields_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flower/config/dependency_injection/di.dart';

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
    emailController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    passwordController.dispose();
    rePasswordController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  void _register(BuildContext context) {
    // prepare names and email and password
    final String firstName = firstNameController.text;
    final String lastName = lastNameController.text;
    final String email = emailController.text;
    final String password = passwordController.text;
    final String phone = phoneController.text;

    // register
      context.read<RegisterCubit>().doEvent(
        Register(
          firstName: firstName,
          lastName: lastName,
          email: email,
          password: password,
          rePassword: rePasswordController.text,
          phone: phone,
          gender: context.read<RegisterCubit>().state.selectedGender,
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<RegisterCubit>(),
      child: BlocListener<RegisterCubit, RegisterState>(
        listenWhen: (previous, current) =>
            previous.registerState != current.registerState,
        listener: (context, state) {
          if (state.registerState.errorMessage != null) {
            CustomSnackBar.error(context, state.registerState.errorMessage!);
          } else if (state.registerState.data != null) {
            //TODO: nav to login
            
          }
        },
        child: Scaffold(
          appBar: AppBar(title: Text(context.signUp)),
          body: SingleChildScrollView(
            child: Center(
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15.0,
                    vertical: 15,
                  ),
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
                      AppSizedBox(height: 25),
                      const GenderSelectionWidget(),
                      AppSizedBox(height: 25),
                      BlocBuilder<RegisterCubit, RegisterState>(
                        builder: (context, state) {
                          if (state.registerState.isLoading) {
                            return const ButtonLoadingWidget();
                          }
                          return PrimaryButton(
                            text: context.signUp,
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                final selectedGender = context
                                    .read<RegisterCubit>()
                                    .state
                                    .selectedGender;
                                if (selectedGender.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(context.requiredField),
                                      backgroundColor: AppColors.error,
                                    ),
                                  );
                                  return;
                                }
                                _register(context);
                              }
                            },
                          );
                        },
                      ),
                      const AppSizedBox(height: 16),
                      AlreadyHaveAccountWidget(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
