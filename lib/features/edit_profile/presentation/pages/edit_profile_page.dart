import 'package:flower/core/localization_constants/edit_profile_constants.dart';
import 'package:flower/core/theme/app_colors.dart';
import 'package:flower/core/widgets/custom_snack_bar.dart';
import 'package:flower/features/edit_profile/presentation/cubit/edit_profile_cubit.dart';
import 'package:flower/features/edit_profile/presentation/widgets/edit_profile_app_bar.dart';
import 'package:flower/features/edit_profile/presentation/widgets/edit_profile_form_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    final s = context.read<EditProfileCubit>().state;
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
        BlocListener<EditProfileCubit, EditProfileState>(
          listenWhen: (previous, current) =>
              previous.submitState != current.submitState,
          listener: (context, state) {
            if (state.submitState.data != null) {
              CustomSnackBar.success(
                  context, EditProfileConstants.updateSuccess);
              Navigator.of(context).pop(true);
            } else if (state.submitState.errorMessage != null) {
              CustomSnackBar.error(context, state.submitState.errorMessage!);
            }
          },
        ),
        BlocListener<EditProfileCubit, EditProfileState>(
          listenWhen: (previous, current) =>
              previous.uploadPhotoState != current.uploadPhotoState,
          listener: (context, state) {
            if (state.uploadPhotoState.data != null) {
              CustomSnackBar.success(
                  context, EditProfileConstants.updateSuccess);
            } else if (state.uploadPhotoState.errorMessage != null) {
              CustomSnackBar.error(
                  context, state.uploadPhotoState.errorMessage!);
            }
          },
        ),
      ],
      child: Scaffold(

        backgroundColor: AppColors.background,
        appBar: const EditProfileAppBar(),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: EditProfileFormBody(
              firstNameController: _firstNameController,
              lastNameController: _lastNameController,
              emailController: _emailController,
              phoneController: _phoneController,
            ),
          ),
        ),
      ),
    );
  }
}
