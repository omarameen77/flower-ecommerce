import 'package:flutter/material.dart';
import 'package:flower/core/theme/app_colors.dart';
import 'package:flower/core/theme/app_text_style.dart';
import 'package:flower/core/widgets/app_sizebox.dart';

class OccasionErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const OccasionErrorView({
    super.key,
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            message,
            textAlign: TextAlign.center,
            style: getRegularStyle(
              context: context,
              color: AppColors.textSecondary,
              fontSize: 16,
            ),
          ),
          const AppSizedBox(height: 16),
          ElevatedButton(onPressed: onRetry, child: const Text('Retry')),
        ],
      ),
    );
  }
}
