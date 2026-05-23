import 'package:flower/core/localization_constants/edit_profile_constants.dart';
import 'package:flower/core/localization_constants/validation_constants.dart';
import 'package:flower/core/utils/app_validator.dart';
import 'package:flower/core/widgets/app_sizebox.dart';
import 'package:flower/core/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

/// Email and phone ([CustomTextField] + [AppValidator]).
class EditProfileEmailPhoneFields extends StatelessWidget {
  const EditProfileEmailPhoneFields({
    super.key,
    required this.emailController,
    required this.phoneController,
    required this.onEmailChanged,
    required this.onPhoneChanged,
  });

  final TextEditingController emailController;
  final TextEditingController phoneController;
  final ValueChanged<String> onEmailChanged;
  final ValueChanged<String> onPhoneChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CustomTextField(
          controller: emailController,
          labelText: EditProfileConstants.email,
          keyboardType: TextInputType.emailAddress,
          validator: AppValidator.email,
          onChanged: onEmailChanged,
        ),
        const AppSizedBox(height: 16),
        CustomTextField(
          controller: phoneController,
          labelText: EditProfileConstants.phone,
          hintText: ValidationConstants.phoneFormatHint,
          keyboardType: TextInputType.phone,
          validator: AppValidator.phone,
          onChanged: onPhoneChanged,
        ),
      ],
    );
  }
}
