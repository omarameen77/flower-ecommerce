import 'package:flower/core/localization_constants/edit_profile_constants.dart';
import 'package:flower/core/utils/app_validator.dart';
import 'package:flower/core/widgets/app_sizebox.dart';
import 'package:flower/core/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

/// First name + last name row ([CustomTextField] + [AppValidator]).
class EditProfileNameRow extends StatelessWidget {
  const EditProfileNameRow({
    super.key,
    required this.firstNameController,
    required this.lastNameController,
    required this.onFirstNameChanged,
    required this.onLastNameChanged,
  });

  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final ValueChanged<String> onFirstNameChanged;
  final ValueChanged<String> onLastNameChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: CustomTextField(
            controller: firstNameController,
            labelText: EditProfileConstants.firstName,
            keyboardType: TextInputType.name,
            validator: AppValidator.name,
            onChanged: onFirstNameChanged,
          ),
        ),
        const AppSizedBox(width: 12),
        Expanded(
          child: CustomTextField(
            controller: lastNameController,
            labelText: EditProfileConstants.lastName,
            keyboardType: TextInputType.name,
            validator: AppValidator.name,
            onChanged: onLastNameChanged,
          ),
        ),
      ],
    );
  }
}
