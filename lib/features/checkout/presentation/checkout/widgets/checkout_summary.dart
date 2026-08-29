import 'package:flower/core/layout/app_size.dart';
import 'package:flower/core/localization_constants/checkout_constants.dart';
import 'package:flower/core/theme/app_colors.dart';
import 'package:flower/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';

class CheckoutSummary extends StatelessWidget {
  final int subtotal;

  const CheckoutSummary({super.key, required this.subtotal});

  @override
  Widget build(BuildContext context) {
    const delivery = 10;
    final total = subtotal + delivery;

    return Container(
      padding: const EdgeInsets.all(AppSize.s16),
      decoration: BoxDecoration(color: AppColors.surface),
      child: Column(
        children: [
          _SummaryRow(
            label: CheckoutConstants.subtotal,
            value: '${CheckoutConstants.egp}$subtotal',
          ),
          const SizedBox(height: AppSize.s8),
          _SummaryRow(
            label: CheckoutConstants.delivery,
            value: '${CheckoutConstants.egp}$delivery',
          ),
          const Divider(height: AppSize.s24, color: AppColors.divider),
          _SummaryRow(
            label: CheckoutConstants.total,
            value: '${CheckoutConstants.egp}$total',
            isBold: true,
          ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isBold;

  const _SummaryRow({
    required this.label,
    required this.value,
    this.isBold = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: isBold
              ? getSemiBoldStyle(context: context, color: AppColors.textPrimary)
              : getRegularStyle(
                  context: context,
                  color: AppColors.textSecondary,
                ),
        ),
        Text(
          value,
          style: isBold
              ? getSemiBoldStyle(context: context, color: AppColors.textPrimary)
              : getRegularStyle(context: context, color: AppColors.textPrimary),
        ),
      ],
    );
  }
}
