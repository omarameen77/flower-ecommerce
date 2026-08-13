import 'package:flower/core/localization_constants/edit_profile_constants.dart';
import 'package:flower/core/theme/app_colors.dart';
import 'package:flower/core/widgets/custom_snack_bar.dart';
import 'package:flower/features/profile/presentation/cubit/profile_edit_cubit.dart';
import 'package:flower/features/profile/presentation/widgets/profile_edit_app_bar.dart';
import 'package:flower/features/profile/presentation/widgets/profile_edit_form_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({super.key});

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    final s = context.read<ProfileEditCubit>().state;
    _firstNameController = TextEditingController(text: s.firstName);
    _lastNameController = TextEditingController(text: s.lastName);
    _emailController = TextEditingController(text: s.email);
    _phoneController = TextEditingController(text: s.phone);
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ProfileEditCubit, ProfileEditState>(
          listenWhen: (previous, current) =>
              previous.submitState != current.submitState,
          listener: (context, state) {
            if (state.submitState.data != null) {
              CustomSnackBar.success(
                context,
                EditProfileConstants.updateSuccess,
              );
              Navigator.of(context).pop(true);
            } else if (state.submitState.errorMessage != null) {
              CustomSnackBar.error(context, state.submitState.errorMessage!);
            }
          },
        ),
        BlocListener<ProfileEditCubit, ProfileEditState>(
          listenWhen: (previous, current) =>
              previous.uploadPhotoState != current.uploadPhotoState,
          listener: (context, state) {
            if (state.uploadPhotoState.data != null) {
              CustomSnackBar.success(
                context,
                EditProfileConstants.updateSuccess,
              );
            } else if (state.uploadPhotoState.errorMessage != null) {
              CustomSnackBar.success(
                context,
                EditProfileConstants.updateSuccess,
              );
            }
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: const ProfileEditAppBar(),
        body: SafeArea(
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: ProfileEditFormBody(
                firstNameController: _firstNameController,
                lastNameController: _lastNameController,
                emailController: _emailController,
                phoneController: _phoneController,
                formKey: _formKey,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
