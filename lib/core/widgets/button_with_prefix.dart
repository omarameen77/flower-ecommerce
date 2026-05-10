import 'package:flower/core/theme/app_colors.dart';
import 'package:flower/core/theme/app_text_style.dart';
import 'package:flower/core/widgets/app_sizebox.dart';
import 'package:flutter/material.dart';

class ButtonWithPrefix extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Widget prefixIcon;
  final double borderRadius;

  const ButtonWithPrefix({
    super.key,
    required this.text,
    required this.onTap,
    required this.prefixIcon,
    this.borderRadius = 22,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textWhite,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        padding: EdgeInsets.zero,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          prefixIcon,
          const AppSizedBox(width: 8),
          Flexible(
            child: Text(
              text,
              maxLines: 1,
              style: getMediumStyle(
                context: context,
                color: AppColors.textWhite,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
