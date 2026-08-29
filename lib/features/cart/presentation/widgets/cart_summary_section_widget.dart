import 'package:flower/core/layout/app_size.dart';
import 'package:flower/core/localization_constants/cart_constants.dart';
import 'package:flower/core/theme/app_colors.dart';
import 'package:flower/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';

class CartSummarySection extends StatelessWidget {
  final int subtotal;

  const CartSummarySection({super.key, required this.subtotal});

  @override
  Widget build(BuildContext context) {
    const delivery = 10;
    final total = subtotal + delivery;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
      decoration: BoxDecoration(color: AppColors.background),
      child: Column(
        children: [
          _row(CartConstants.subTotal, subtotal, context: context),

          const SizedBox(height: 8),

          _row(CartConstants.delivery, delivery, context: context),

          const SizedBox(height: 10),

          Divider(height: 1, color: AppColors.divider.withValues(alpha: 0.7)),

          const SizedBox(height: 10),

          _totalRow(CartConstants.total, total, context: context),
        ],
      ),
    );
  }

  Widget _row(String title, int value, {required BuildContext context}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: getRegularStyle(
            color: AppColors.textSecondary,
            fontSize: AppSize.s14,
            context: context,
          ),
        ),

        Text(
          '${CartConstants.egp}$value',
          style: getRegularStyle(
            color: AppColors.textPrimary,
            fontSize: AppSize.s14,
            context: context,
          ),
        ),
      ],
    );
  }

  Widget _totalRow(String title, int value, {required BuildContext context}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: getSemiBoldStyle(
            color: AppColors.textPrimary,
            fontSize: AppSize.s16,
            context: context,
          ),
        ),

        Text(
          '${CartConstants.egp}$value',
          style: getBoldStyle(
            color: AppColors.textPrimary,
            fontSize: AppSize.s16,
            context: context,
          ),
        ),
      ],
    );
  }
}
