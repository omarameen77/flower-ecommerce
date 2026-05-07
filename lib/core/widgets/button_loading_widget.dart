import 'package:flower/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ButtonLoadingWidget extends StatelessWidget {
  const ButtonLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.primary.withOpacity(0.4),
      highlightColor: AppColors.primaryLight.withOpacity(0.6),
      child: Container(
        width: double.infinity,
        height: 52,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(25),
        ),
      ),
    );
  }
}
