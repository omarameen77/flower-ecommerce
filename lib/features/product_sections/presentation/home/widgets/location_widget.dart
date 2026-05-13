import 'package:flower/core/theme/app_colors.dart';
import 'package:flower/core/theme/app_text_style.dart';
import 'package:flower/core/theme/font_size_manager.dart';
import 'package:flutter/material.dart';

class LocationWidget extends StatelessWidget {
  const LocationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.location_on_outlined, color: AppColors.textPrimary, size: 20),
        const SizedBox(width: 4),
        Expanded(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Deliver to ',
                  style: getRegularStyle(
                    context: context,
                    fontSize: FontSizeManager.s14,
                    color: AppColors.textPrimary,
                  ),
                ),
                TextSpan(
                  text: '2XVP+XC - Sheikh Zayed',
                  style: getSemiBoldStyle(
                    context: context,
                    fontSize: FontSizeManager.s14,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: 4),
        Icon(Icons.keyboard_arrow_down, color: AppColors.primary, size: 20),
      ],
    );
  }
}
