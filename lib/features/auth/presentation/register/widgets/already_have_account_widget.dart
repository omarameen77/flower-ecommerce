import 'package:flower/core/localization_constants/auth_constants.dart';
import 'package:flower/core/theme/app_colors.dart';
import 'package:flower/core/theme/app_text_style.dart';
import 'package:flower/core/widgets/app_sizebox.dart';
import 'package:flutter/material.dart';

class AlreadyHaveAccountWidget extends StatelessWidget {
  final VoidCallback? onTap;

  const AlreadyHaveAccountWidget({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          context.alreadyHaveAccount,
          style: getRegularStyle(
            context: context,
            color: AppColors.textPrimary,
            fontSize: 14,
          ),
        ),
        const AppSizedBox(width: 4),
        GestureDetector(
          onTap: onTap,
          child: Text(
            context.login,
            style:
                getSemiBoldStyle(
                  context: context,
                  color: AppColors.primary,
                  fontSize: 14,
                ).copyWith(
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.primary,
                ),
          ),
        ),
      ],
    );
  }
}
