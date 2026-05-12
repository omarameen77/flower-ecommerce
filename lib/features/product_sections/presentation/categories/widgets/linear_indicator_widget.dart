import 'package:flower/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class LinearIndicatorWidget extends StatelessWidget {
  final dynamic productState;

  const LinearIndicatorWidget({super.key, required this.productState});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 4,
      child: productState
          ? ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: ShaderMask(
                shaderCallback: (bounds) {
                  return const LinearGradient(
                    colors: [
                      AppColors.primaryLight,
                      AppColors.primaryLight,
                      AppColors.warning,
                      AppColors.background,
                    ],
                  ).createShader(bounds);
                },
                child: const LinearProgressIndicator(
                  minHeight: 4,
                  backgroundColor: Colors.white24,
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.surface),
                ),
              ),
            )
          : const SizedBox.shrink(),
    );
  }
}
