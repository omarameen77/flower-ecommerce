import 'package:flower/core/theme/app_colors.dart';
import 'package:flower/core/theme/app_text_style.dart';
import 'package:flower/core/theme/font_size_manager.dart';
import 'package:flower/core/widgets/app_sizebox.dart';
import 'package:flutter/material.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({super.key, required this.title, required this.subtitle});
  final String title;
  final String subtitle;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: getSemiBoldStyle(
              context: context,
              fontSize: FontSizeManager.s20,
              color: AppColors.textPrimary,
            ),
          ),
          const AppSizedBox(height: 6),
          Text(
            subtitle,
            style: getRegularStyle(
              context: context,
              fontSize: FontSizeManager.s14,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
