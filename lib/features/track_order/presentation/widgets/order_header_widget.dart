import 'package:flower/core/localization_constants/checkout_constants.dart';
import 'package:flower/core/theme/app_colors.dart';
import 'package:flower/core/theme/app_text_style.dart';
import 'package:flower/features/track_order/domain/entities/track_order_entity.dart';
import 'package:flutter/material.dart';

class OrderHeaderWidget extends StatelessWidget {
  final OrderData? order;

  const OrderHeaderWidget({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                order?.orderNumber ?? '',
                style: getBoldStyle(
                  context: context,
                  fontSize: 22,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                (order?.state?.name ?? '').toUpperCase(),
                style: getMediumStyle(
                  context: context,
                  fontSize: 14,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ),
        if (order?.totalPrice != null)
          Text(
            '${CheckoutConstants.egp}${order!.totalPrice!.toStringAsFixed(2)}',
            style: getBoldStyle(
              context: context,
              fontSize: 20,
              color: AppColors.textPrimary,
            ),
          ),
      ],
    );
  }
}
