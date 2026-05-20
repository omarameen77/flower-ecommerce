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
      color: AppColors.background,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          _row(CartConstants.subTotal, subtotal, context: context),
          _row(CartConstants.delivery, delivery, context: context),
          const Divider(color: AppColors.grey600),
          _totalRow(CartConstants.total, total, context: context),
        ],
      ),
    );
  }

  Widget _row(String t, int v, {required BuildContext context}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          t,
          style: getRegularStyle(
            color: AppColors.textPrimary,
            fontSize: AppSize.s14,
            context: context,
          ),
        ),
        Text(
          '${CartConstants.egp}$v',
          style: getRegularStyle(
            color: AppColors.textPrimary,
            fontSize: AppSize.s14,
            context: context,
          ),
        ),
      ],
    );
  }

  Widget _totalRow(String t, int v, {required BuildContext context}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          t,
          style: getSemiBoldStyle(
            color: AppColors.textPrimary,
            fontSize: AppSize.s16,
            context: context,
          ),
        ),
        Text(
          '${CartConstants.egp}$v',
          style: getSemiBoldStyle(
            color: AppColors.textPrimary,
            fontSize: AppSize.s16,
            context: context,
          ),
        ),
      ],
    );
  }
}
