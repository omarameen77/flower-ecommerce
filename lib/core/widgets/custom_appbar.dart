import 'package:flower/core/theme/app_colors.dart';
import 'package:flower/core/theme/app_text_style.dart';
import 'package:flower/core/theme/font_size_manager.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String? subtitle;
  final bool showBackButton;
  final List<Widget>? actions;
  final bool buttonEnable;

  const CustomAppBar({
    super.key,
    required this.title,
    this.subtitle,
    this.showBackButton = true,
    this.buttonEnable = true,
    this.actions,
  });

  static const _subtitleHeight = 24.0;

  @override
  Size get preferredSize => Size.fromHeight(
    subtitle == null ? kToolbarHeight : kToolbarHeight + _subtitleHeight,
  );

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 0,
      toolbarHeight: preferredSize.height,
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
      title: subtitle == null
          ? _buildTitle(context)
          : Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTitle(context),
                Text(
                  subtitle!,
                  style: getRegularStyle(
                    context: context,
                    color: AppColors.textSecondary,
                    fontSize: FontSizeManager.s14,
                  ),
                ),
              ],
            ),
      actions: actions,
    );
  }

  Widget _buildTitle(BuildContext context) => Text(
    title,
    style: getMediumStyle(
      context: context,
      color: AppColors.textPrimary,
      fontSize: 20,
    ),
  );
}
