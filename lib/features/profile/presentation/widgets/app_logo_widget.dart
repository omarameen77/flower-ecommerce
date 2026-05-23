import 'package:flower/core/resources/app_strings.dart';
import 'package:flower/core/resources/app_svgs.dart';
import 'package:flower/core/theme/app_colors.dart';
import 'package:flower/core/theme/app_text_style.dart';
import 'package:flower/core/theme/font_size_manager.dart';
import 'package:flower/core/widgets/app_sizebox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class AppLogoWidget extends StatelessWidget {
  const AppLogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(AppSvgs.splashLogo, height: 20),
        AppSizedBox(width: 8),
        Text(
          AppStrings.appLogo,
          style: getMediumStyle(context: context, color: AppColors.primary)
              .copyWith(
                fontSize: FontSizeManager.s20,
                fontWeight: FontWeight.w400,
                height: 1.0,
                letterSpacing: 0,
                fontFamily: GoogleFonts.imFellEnglish().fontFamily,
              ),
        ),
      ],
    );
  }
}
