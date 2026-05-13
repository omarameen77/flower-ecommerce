import 'package:flower/core/theme/app_colors.dart';
import 'package:flower/features/product_sections/presentation/home/home_design_tokens.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class HomeProductCardShimmer extends StatelessWidget {
  const HomeProductCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.grey400,
      highlightColor: AppColors.grey200,
      child: SizedBox(
        width: HomeTokens.productCardWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: HomeTokens.productCardWidth,
              height: HomeTokens.productCardImageHeight,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: 120,
              height: 14,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(height: 6),
            Container(
              width: 80,
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
