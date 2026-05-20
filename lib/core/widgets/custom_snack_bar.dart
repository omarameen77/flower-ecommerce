import 'package:flutter/material.dart';
import 'package:flower/core/theme/app_colors.dart';
import 'package:flower/core/theme/app_text_style.dart';

class CustomSnackBar {
  static void _show(
    BuildContext context, {
    required String message,
    required Color backgroundColor,
    required IconData icon,
  }) {
    final messenger = ScaffoldMessenger.of(context);

    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(icon, color: AppColors.surface),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  maxLines: 1,
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                  message,
                  style: getMediumStyle(
                    context: context,
                    color: AppColors.textWhite,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          backgroundColor: backgroundColor,
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        ),
      );
  }

  static void success(BuildContext context, String message) {
    _show(
      context,
      message: message,
      backgroundColor: AppColors.success,
      icon: Icons.check_circle,
    );
  }

  static void error(BuildContext context, String message) {
    _show(
      context,
      message: message,
      backgroundColor: AppColors.error,
      icon: Icons.error,
    );
  }

  static void info(
    BuildContext context,
    String message, {
    IconData icon = Icons.info,
  }) {
    _show(
      context,
      message: message,
      backgroundColor: AppColors.grey900,
      icon: icon,
    );
  }
}
