import 'package:flower/core/localization_constants/edit_profile_constants.dart';
import 'package:flower/core/theme/app_colors.dart';
import 'package:flower/core/theme/app_text_style.dart';
import 'package:flower/core/theme/font_size_manager.dart';
import 'package:flower/core/widgets/app_sizebox.dart';
import 'package:flower/core/widgets/button_loading_widget.dart';
import 'package:flower/core/widgets/primary_button.dart';
import 'package:flutter/material.dart';

/// Update action: [ButtonLoadingWidget] while loading, else [PrimaryButton] (app theme).
class EditProfileUpdateSection extends StatelessWidget {
  const EditProfileUpdateSection({
    super.key,
    required this.canSubmit,
    required this.loading,
    required this.showNoChangesHint,
    required this.onUpdate,
  });

  final bool canSubmit;
  final bool loading;
  final bool showNoChangesHint;
  final VoidCallback onUpdate;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (loading)
          const ButtonLoadingWidget()
        else
          PrimaryButton(
            text: EditProfileConstants.update,
            onTap: () {
              if (canSubmit) {
                onUpdate();
              }
            },
          ),
        if (showNoChangesHint) ...[
          const AppSizedBox(height: 8),
          Text(
            EditProfileConstants.noChanges,
            textAlign: TextAlign.center,
            style: getRegularStyle(
              context: context,
              fontSize: FontSizeManager.s12,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ],
    );
  }
}
