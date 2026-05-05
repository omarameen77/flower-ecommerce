import 'package:flower/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

AppBar customAppBar(BuildContext context, {required String title}) {
  return AppBar(
    titleSpacing: 0,
    leading: IconButton(
      icon: const Icon(Icons.arrow_back_ios, color: AppColors.textPrimary),
      onPressed: () {
        Navigator.pop(context);
      },
    ),
    title: Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimary,
      ),
    ),
  );
}
