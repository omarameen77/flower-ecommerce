import 'package:flower/core/localization_constants/checkout_constants.dart';
import 'package:flower/core/localization_constants/track_order_constants.dart';
import 'package:flower/core/theme/app_colors.dart';
import 'package:flower/core/theme/app_text_style.dart';
import 'package:flower/features/track_order/domain/entities/track_order_entity.dart';
import 'package:flutter/material.dart';

class TotalSectionWidget extends StatelessWidget {
  final OrderData order;

  const TotalSectionWidget({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.035),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                TrackOrderConstants.total,
                style: getMediumStyle(
                  context: context,
                  fontSize: 15,
                  color: AppColors.textPrimary,
                ),
              ),

              Text(
                '${CheckoutConstants.egp}'
                '${order.totalPrice?.toStringAsFixed(2) ?? '0.00'}',
                style: getBoldStyle(
                  context: context,
                  fontSize: 17,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),

          if (order.paymentType != null) ...[
            const SizedBox(height: 10),

            Divider(height: 1, color: AppColors.divider.withValues(alpha: 0.7)),

            const SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  TrackOrderConstants.payment,
                  style: getRegularStyle(
                    context: context,
                    fontSize: 13,
                    color: AppColors.textSecondary,
                  ),
                ),

                Text(
                  order.paymentType!.toUpperCase(),
                  style: getMediumStyle(
                    context: context,
                    fontSize: 13,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
