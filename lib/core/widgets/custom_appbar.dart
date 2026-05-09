import 'package:flower/core/theme/app_colors.dart';
import 'package:flower/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final List<Widget>? actions;
  final bool buttonEnable;

  const CustomAppBar({
    super.key,
    required this.title,
    this.showBackButton = true,
    this.buttonEnable = true,
    this.actions,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 0,
      leading: showBackButton
          ? GestureDetector(
              child: const Icon(
                Icons.arrow_back_ios,
                color: AppColors.textPrimary,
              ),
              onTap: () {
                buttonEnable ? Navigator.pop(context) : null;
              },
            )
          : null,

      title: Text(
        title,
        style: getMediumStyle(
          context: context,
          color: AppColors.textPrimary,
          fontSize: 20,
        ),
      ),

      actions: actions,
    );
  }
}
