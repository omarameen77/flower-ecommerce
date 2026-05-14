import 'package:flower/core/localization_constants/edit_profile_constants.dart';
import 'package:flower/core/theme/app_colors.dart';
import 'package:flower/core/theme/app_text_style.dart';
import 'package:flower/core/widgets/app_sizebox.dart';
import 'package:flower/features/edit_profile/presentation/cubit/edit_profile_cubit.dart';
import 'package:flower/features/edit_profile/presentation/cubit/edit_profile_event.dart';
import 'package:flower/features/edit_profile/presentation/widgets/edit_profile_email_phone_fields.dart';
import 'package:flower/features/edit_profile/presentation/widgets/edit_profile_name_row.dart';
import 'package:flower/features/edit_profile/presentation/widgets/edit_profile_update_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Scrollable form: name, email/phone, password change link, update section.
class EditProfileFormBody extends StatelessWidget {
  const EditProfileFormBody({
    super.key,
    required this.firstNameController,
    required this.lastNameController,
    required this.emailController,
    required this.phoneController,
  });

  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditProfileCubit, EditProfileState>(
      buildWhen: (previous, current) =>
          previous.firstName != current.firstName ||
          previous.lastName != current.lastName ||
          previous.email != current.email ||
          previous.phone != current.phone ||
          previous.submitState != current.submitState,
      builder: (context, state) {
        final cubit = context.read<EditProfileCubit>();
        final loading = state.submitState.isLoading;
        final canSubmit = cubit.hasChanges && !loading;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            EditProfileNameRow(
              firstNameController: firstNameController,
              lastNameController: lastNameController,
              onFirstNameChanged: (v) =>
                  cubit.doEvent(EditProfileFirstNameChanged(v)),
              onLastNameChanged: (v) =>
                  cubit.doEvent(EditProfileLastNameChanged(v)),
            ),
            const AppSizedBox(height: 16),
            EditProfileEmailPhoneFields(
              emailController: emailController,
              phoneController: phoneController,
              onEmailChanged: (v) => cubit.doEvent(EditProfileEmailChanged(v)),
              onPhoneChanged: (v) => cubit.doEvent(EditProfilePhoneChanged(v)),
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
                    //TODO: nav to reset passowrd
                  },
                  child: Text(
                    EditProfileConstants.changePassword,
                    style: getTextWithLine(context: context),
                  ),
                ),
              ],
            ),
            const AppSizedBox(height: 28),
            EditProfileUpdateSection(
              canSubmit: canSubmit,
              loading: loading,
              showNoChangesHint: !cubit.hasChanges && !loading,
              onUpdate: () => cubit.doEvent(const EditProfileSubmitted()),
            ),
          ],
        );
      },
    );
  }
}
