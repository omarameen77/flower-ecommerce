import 'package:flower/core/localization_constants/notifications_constants.dart';
import 'package:flower/core/theme/app_colors.dart';
import 'package:flower/core/theme/app_text_style.dart';
import 'package:flower/core/widgets/app_sizebox.dart';
import 'package:flutter/material.dart';

class AppErrorWidget extends StatelessWidget {
  final String errorMessage;
  final VoidCallback onRetry;
  final String? retryButtonText;

  const AppErrorWidget({
    super.key,
    required this.errorMessage,
    required this.onRetry,
    this.retryButtonText,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.error.withAlpha(35),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.error, color: AppColors.error, size: 48),
            ),
            const AppSizedBox(height: 24),

            Text(
              NotificationsConstants.errorTitle,
              style: getBoldStyle(
                color: AppColors.textPrimary,
                fontSize: 18,
                context: context,
              ),
              textAlign: TextAlign.center,
            ),
            const AppSizedBox(height: 8),

            Text(
              errorMessage,
              textAlign: TextAlign.center,
              style: getMediumStyle(color: AppColors.grey800, context: context),
            ),
            const AppSizedBox(height: 32),

            SizedBox(
              width: MediaQuery.of(context).size.width * 0.45,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.textPrimary,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: onRetry,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.refresh_rounded, size: 18),
                    const AppSizedBox(width: 8),
                    Text(
                      retryButtonText ?? NotificationsConstants.retry,
                      style: getMediumStyle(
                        color: AppColors.textWhite,
                        context: context,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
