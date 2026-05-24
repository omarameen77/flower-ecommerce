import 'package:flower/core/localization_constants/cart_constants.dart';
import 'package:flower/core/resources/app_svgs.dart';
import 'package:flower/core/theme/app_colors.dart';
import 'package:flower/core/theme/app_text_style.dart';
import 'package:flower/core/widgets/app_sizebox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StaticLocationWidget extends StatelessWidget {
  const StaticLocationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(AppSvgs.location),
        const AppSizedBox(width: 8),
        Text.rich(
          TextSpan(
            text: CartConstants.deliveringTo,
            style: getMediumStyle(context: context, color: AppColors.grey900),
            children: [
              TextSpan(
                text: CartConstants.staticLocation,
                style: getMediumStyle(
                  context: context,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
        SvgPicture.asset(AppSvgs.arrowRight),
      ],
    );
  }
}
