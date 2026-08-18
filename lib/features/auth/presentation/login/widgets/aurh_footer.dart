import 'package:flower/core/theme/app_colors.dart';
import 'package:flower/core/theme/app_text_style.dart';
import 'package:flower/core/widgets/app_sizebox.dart';
import 'package:flutter/material.dart';

class AuthFooter extends StatelessWidget {
  const AuthFooter({
    super.key,
    required this.question,
    required this.actionLabel,
    required this.onActionTap,
  });

  final String question;
  final String actionLabel;
  final VoidCallback onActionTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          question,
          style: getRegularStyle(
            context: context,
            color: AppColors.textPrimary,
          ),
        ),
        const AppSizedBox(width: 4),
        InkWell(
          onTap: onActionTap,
          child: Text(
            actionLabel,
            style: getSemiBoldStyle(
              context: context,
              color: AppColors.primary,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}
