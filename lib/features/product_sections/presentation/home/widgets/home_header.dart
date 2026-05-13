import 'package:flower/core/resources/app_svgs.dart';
import 'package:flower/core/theme/app_colors.dart';
import 'package:flower/core/theme/app_text_style.dart';
import 'package:flower/core/theme/font_size_manager.dart';
import 'package:flower/core/widgets/app_sizebox.dart';
import 'package:flower/features/product_sections/presentation/home/home_design_tokens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(AppSvgs.splashLogo, height: 20),
        AppSizedBox(width: 8),
        Text( 'Flowery',
        style: getMediumStyle(
          context: context,
          color: AppColors.primary,
        ).copyWith(fontSize: FontSizeManager.s20,fontWeight: FontWeight.w400,height: 1.0, letterSpacing: 0,fontFamily: GoogleFonts.imFellEnglish().fontFamily,)
        ),
        AppSizedBox(width: 12),
        Expanded(
          child: GestureDetector(
            onTap: (){},
            child: Container(
              height: HomeTokens.searchBarHeight,
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.border),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  Icon(
                    Icons.search_outlined,
                    color: AppColors.textHint,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Search',
                    style: getRegularStyle(
                      context: context,
                      color: AppColors.textHint,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
