import 'package:flower/core/layout/app_size.dart';
import 'package:flower/core/localization_constants/auth_constants.dart';
import 'package:flower/core/theme/app_colors.dart';
import 'package:flower/core/theme/app_text_style.dart';
import 'package:flower/core/theme/font_size_manager.dart';
import 'package:flower/core/widgets/app_sizebox.dart';
import 'package:flutter/material.dart';

class PinErrorRow extends StatelessWidget {
  final String? message;

  const PinErrorRow({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const Icon(
          Icons.error_outline,
          color: AppColors.error,
          size: AppSize.s16,
        ),
        const AppSizedBox(width: AppSize.s4),
        Text(
          message ?? context.invalidCode,
          style: getRegularStyle(
            context: context,
            fontSize: FontSizeManager.s12,
            color: AppColors.error,
          ),
        ),
      ],
    );
  }
}
