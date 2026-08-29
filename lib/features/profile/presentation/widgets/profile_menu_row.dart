import 'package:flower/core/theme/app_colors.dart';
import 'package:flower/core/theme/app_text_style.dart';
import 'package:flower/core/widgets/app_sizebox.dart';
import 'package:flutter/material.dart';

class ProfileMenuRow extends StatelessWidget {
  const ProfileMenuRow({
    super.key,
    required this.title,
    this.leading,
    this.trailing,
    this.onTap,
    this.iconBackgroundColor,
    this.titleColor,
  });

  final String title;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;

  /// When set, [leading] is wrapped in a soft rounded badge using this
  /// color, instead of being rendered bare. Keeps icon-less rows (About
  /// us, Terms) visually lighter than the ones with an icon.
  final Color? iconBackgroundColor;

  final Color? titleColor;

  @override
  Widget build(BuildContext context) {
    Widget? leadingWidget = leading;
    if (leadingWidget != null && iconBackgroundColor != null) {
      leadingWidget = Container(
        width: 36,
        height: 36,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: iconBackgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: leadingWidget,
      );
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              if (leadingWidget != null) ...[
                leadingWidget,
                const AppSizedBox(width: 12),
              ],
              Expanded(
                child: Text(
                  title,
                  style: getRegularStyle(
                    context: context,
                    color: titleColor ?? AppColors.textPrimary,
                  ),
                ),
              ),
              trailing ??
                  const Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 14,
                    color: Colors.black26,
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
