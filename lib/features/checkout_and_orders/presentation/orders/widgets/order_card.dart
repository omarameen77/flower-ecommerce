import 'package:flower/core/localization_constants/checkout_constants.dart';
import 'package:flower/core/localization_constants/orders_constants.dart';
import 'package:flower/core/theme/app_colors.dart';
import 'package:flower/core/theme/app_text_style.dart';
import 'package:flower/core/theme/font_size_manager.dart';
import 'package:flower/core/widgets/cached_network_image.dart';
import 'package:flower/core/widgets/primary_button.dart';
import 'package:flower/features/checkout_and_orders/domain/models/order_model.dart';
import 'package:flutter/material.dart';

class OrderCard extends StatelessWidget {
  final OrderModel order;

  const OrderCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.grey700, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImageWidget(
              urlToImage: order.productImage,
              width: 130,
              height: 130,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  order.productTitle,
                  style: getRegularStyle(
                    context: context,
                    fontSize: FontSizeManager.s12,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${CheckoutConstants.egp}${order.totalPrice}',
                  style: getBoldStyle(
                    context: context,
                    fontSize: FontSizeManager.s18,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${OrdersConstants.orderNumber}${order.orderNumber.replaceAll('#', '')}',
                  style: getRegularStyle(
                    context: context,
                    fontSize: FontSizeManager.s12,
                    color: AppColors.grey900,
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: PrimaryButton(text: OrdersConstants.trackOrder, onTap: () {}),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
