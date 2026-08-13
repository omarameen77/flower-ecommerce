import 'package:flower/config/routes/routes.dart';
import 'package:flower/core/localization_constants/edit_profile_constants.dart';
import 'package:flower/core/theme/app_colors.dart';
import 'package:flower/core/theme/app_text_style.dart';
import 'package:flower/core/widgets/app_sizebox.dart';
import 'package:flower/features/profile/presentation/cubit/profile_edit_cubit.dart';
import 'package:flower/features/profile/presentation/cubit/profile_edit_event.dart';
import 'package:flower/features/profile/presentation/widgets/profile_edit_email_phone_fields.dart';
import 'package:flower/features/profile/presentation/widgets/profile_edit_name_row.dart';
import 'package:flower/features/profile/presentation/widgets/profile_edit_photo_header.dart';
import 'package:flower/features/profile/presentation/widgets/profile_edit_update_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileEditFormBody extends StatelessWidget {
  const ProfileEditFormBody({
    super.key,
    required this.firstNameController,
    required this.lastNameController,
    required this.emailController,
    required this.phoneController,
    required this.formKey,
  });

  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileEditCubit, ProfileEditState>(
      buildWhen: (previous, current) =>
          previous.firstName != current.firstName ||
          previous.lastName != current.lastName ||
          previous.email != current.email ||
          previous.phone != current.phone ||
          previous.photo != current.photo ||
          previous.submitState != current.submitState ||
          previous.uploadPhotoState != current.uploadPhotoState,
      builder: (context, state) {
        final cubit = context.read<ProfileEditCubit>();
        final loading =
            state.submitState.isLoading || state.uploadPhotoState.isLoading;
        final canSubmit = cubit.hasChanges && !loading;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ProfileEditPhotoHeader(initialImageUrl: state.profilePhotoUrl),
            const AppSizedBox(height: 24),
            ProfileEditNameRow(
              firstNameController: firstNameController,
              lastNameController: lastNameController,
              onFirstNameChanged: (v) =>
                  cubit.doEvent(ProfileEditFirstNameChanged(v)),
              onLastNameChanged: (v) =>
                  cubit.doEvent(ProfileEditLastNameChanged(v)),
            ),
            const AppSizedBox(height: 16),
            ProfileEditEmailPhoneFields(
              emailController: emailController,
              phoneController: phoneController,
              onEmailChanged: (v) => cubit.doEvent(ProfileEditEmailChanged(v)),
              onPhoneChanged: (v) => cubit.doEvent(ProfileEditPhoneChanged(v)),
            ),
            const AppSizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  EditProfileConstants.password,
                  style: getRegularStyle(
                    context: context,
                    color: AppColors.textPrimary,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.changePassword);
                  },
                  child: Text(
                    EditProfileConstants.changePassword,
                    style: getTextWithLine(context: context),
                  ),
                ),
              ],
            ),
            const AppSizedBox(height: 28),
            ProfileEditUpdateSection(
              canSubmit: canSubmit,
              loading: loading,
              showNoChangesHint: !cubit.hasChanges && !loading,
              onUpdate: () {
                if (formKey.currentState?.validate() ?? false) {
                  cubit.doEvent(const ProfileEditSubmitted());
                }
              },
            ),
          ],
        );
      },
    );
  }
}
