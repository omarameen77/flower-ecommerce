import 'package:flower/config/routes/routes.dart';
import 'package:flower/core/localization_constants/checkout_constants.dart';
import 'package:flower/core/theme/app_colors.dart';
import 'package:flower/core/theme/app_text_style.dart';
import 'package:flower/core/widgets/primary_button.dart';
import 'package:flutter/material.dart';

class ThankYouPage extends StatelessWidget {
  const ThankYouPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check,
                  size: 64,
                  color: AppColors.textWhite,
                ),
              ),
              const SizedBox(height: 32),
              Text(
                CheckoutConstants.orderPlaced,
                textAlign: TextAlign.center,
                style: getBoldStyle(
                  context: context,
                  fontSize: 28,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                CheckoutConstants.thankYouMessage,
                textAlign: TextAlign.center,
                style: getRegularStyle(
                  context: context,
                  fontSize: 16,
                  color: AppColors.textSecondary,
                ),
              ),
              const Spacer(flex: 2),
              PrimaryButton(
                text: CheckoutConstants.continueShopping,
                onTap: () =>
                    Navigator.pushReplacementNamed(context, Routes.appSections),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
