import 'package:flower/config/routes/routes.dart';
import 'package:flower/core/localization_constants/checkout_constants.dart';
import 'package:flower/core/localization_constants/orders_constants.dart';
import 'package:flower/core/theme/app_colors.dart';
import 'package:flower/core/theme/app_text_style.dart';
import 'package:flower/core/theme/font_size_manager.dart';
import 'package:flower/core/widgets/cached_network_image.dart';
import 'package:flower/core/widgets/primary_button.dart';
import 'package:flower/features/orders/domain/models/order_model.dart';
import 'package:flutter/material.dart';

class OrderCard extends StatelessWidget {
  final OrderModel order;

  const OrderCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.045),
            blurRadius: 12,
            spreadRadius: 0,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product image
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: CachedNetworkImageWidget(
              urlToImage: order.productImage,
              width: 100,
              height: 105,
            ),
          ),

          const SizedBox(width: 12),

          // Order information
          Expanded(
            child: SizedBox(
              height: 112,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product name
                  Text(
                    order.productTitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: getMediumStyle(
                      context: context,
                      fontSize: FontSizeManager.s14,
                      color: AppColors.textPrimary,
                    ),
                  ),

                  const SizedBox(height: 5),

                  // Price
                  Text(
                    '${CheckoutConstants.egp}${order.totalPrice}',
                    style: getBoldStyle(
                      context: context,
                      fontSize: FontSizeManager.s16,
                      color: AppColors.primary,
                    ),
                  ),

                  const SizedBox(height: 4),

                  // Order number
                  Text(
                    '${OrdersConstants.orderNumber} ${order.orderNumber}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: getRegularStyle(
                      context: context,
                      fontSize: FontSizeManager.s12,
                      color: AppColors.success,
                    ),
                  ),

                  const Spacer(),

                  // Track button
                  SizedBox(
                    height: 32,
                    width: double.infinity,
                    child: PrimaryButton(
                      text: OrdersConstants.trackOrder,
                      onTap: () => Navigator.pushNamed(
                        context,
                        Routes.trackOrder,
                        arguments: {
                          'orderId': order.id,
                          'orderData': {
                            'orderId': order.id,
                            'state': order.state,
                            'isDelivered': order.isDelivered,
                            'order': {
                              'id': order.id,
                              'orderNumber': order.orderNumber,
                              'totalPrice': order.totalPrice,
                              'paymentType': order.paymentType,
                              'isPaid': order.isPaid,
                              'isDelivered': order.isDelivered,
                              'state': order.state,
                              'createdAt': order.createdAt,
                            },
                          },
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
