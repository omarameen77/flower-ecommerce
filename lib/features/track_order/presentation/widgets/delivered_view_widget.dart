import 'package:flower/config/routes/routes.dart';
import 'package:flower/core/localization_constants/track_order_constants.dart';
import 'package:flower/core/theme/app_colors.dart';
import 'package:flower/core/theme/app_text_style.dart';
import 'package:flower/core/widgets/primary_button.dart';
import 'package:flutter/material.dart';

class DeliveredViewWidget extends StatelessWidget {
  const DeliveredViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(flex: 2),
            Container(
              width: 120,
              height: 120,
              decoration: const BoxDecoration(
                color: AppColors.success,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check, size: 64, color: AppColors.textWhite),
            ),
            const SizedBox(height: 32),
            Text(
              TrackOrderConstants.orderDelivered,
              textAlign: TextAlign.center,
              style: getBoldStyle(context: context, fontSize: 24, color: AppColors.textPrimary),
            ),
            const SizedBox(height: 16),
            Text(
              TrackOrderConstants.thankYouMessage,
              textAlign: TextAlign.center,
              style: getRegularStyle(context: context, fontSize: 16, color: AppColors.textSecondary),
            ),
            const Spacer(flex: 2),
            PrimaryButton(
              text: TrackOrderConstants.continueShopping,
              onTap: () => Navigator.pushReplacementNamed(context, Routes.appSections),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
