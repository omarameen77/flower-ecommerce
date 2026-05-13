import 'package:flower/core/theme/app_colors.dart';
import 'package:flower/core/widgets/app_sizebox.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProductWidgetShimmer extends StatelessWidget {
  const ProductWidgetShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.primary.withAlpha((0.18 * 255).round()),
      highlightColor: AppColors.primaryLight.withAlpha((0.28 * 255).round()),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border),
        ),
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Stack(
                  children: [
                    Container(width: double.infinity, color: AppColors.primaryLight),
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        margin: const EdgeInsets.all(8),
                        width: 22,
                        height: 22,
                        decoration: const BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Container(
                        margin: const EdgeInsets.all(8),
                        width: 64,
                        height: 12,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const AppSizedBox(height: 8),
            _skeletonBar(width: 78, height: 10),
            const AppSizedBox(height: 4),
            _skeletonBar(width: 112, height: 11),
            const AppSizedBox(height: 6),
            Row(
              children: [
                _skeletonBar(width: 56, height: 12),
                const AppSizedBox(width: 6),
                _skeletonBar(width: 34, height: 10),
                const AppSizedBox(width: 4),
                _skeletonBar(width: 24, height: 10),
              ],
            ),
            const AppSizedBox(height: 8),
            Container(
              width: double.infinity,
              height: 34,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(22),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 14,
                    height: 14,
                    decoration: const BoxDecoration(
                      color: AppColors.primaryLight,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const AppSizedBox(width: 8),
                  _skeletonBar(
                    width: 60,
                    height: 10,
                    color: AppColors.primaryLight,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _skeletonBar({
    required double width,
    required double height,
    Color color = AppColors.primary,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }
}
