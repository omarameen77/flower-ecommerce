import 'package:flower/core/theme/app_colors.dart';
import 'package:flower/features/product_sections/presentation/home/home_design_tokens.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class OccasionItemShimmer extends StatelessWidget {
  const OccasionItemShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.grey400,
      highlightColor: AppColors.grey200,
      child: SizedBox(
        width: HomeTokens.occasionCardWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: HomeTokens.occasionCardWidth,
              height: HomeTokens.occasionCardImageHeight,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: 100,
              height: 14,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
