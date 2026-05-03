import 'package:flower/core/layout/app_size.dart';
import 'package:flower/core/theme/app_colors.dart';
import 'package:flower/core/theme/app_text_style.dart';
import 'package:flower/core/theme/font_size_manager.dart';
import 'package:flower/core/widgets/app_sizebox.dart';
import 'package:flutter/material.dart';

class AuthHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const AuthHeader({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: getBoldStyle(
            context: context,
            fontSize: FontSizeManager.s24,
            color: AppColors.textPrimary,
          ),
        ),
        AppSizedBox(height: AppSize.s10),
        Text(
          subtitle,
          style: getRegularStyle(
            context: context,
            fontSize: FontSizeManager.s14,
            color: AppColors.grey900,
          ),
        ),
      ],
    );
  }
}
