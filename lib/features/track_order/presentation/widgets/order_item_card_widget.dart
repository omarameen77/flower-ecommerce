import 'package:flower/core/localization_constants/checkout_constants.dart';
import 'package:flower/core/localization_constants/track_order_constants.dart';
import 'package:flower/core/theme/app_colors.dart';
import 'package:flower/core/theme/app_text_style.dart';
import 'package:flower/core/widgets/cached_network_image.dart';
import 'package:flower/features/track_order/domain/entities/track_order_entity.dart';
import 'package:flutter/material.dart';

class OrderItemCardWidget extends StatelessWidget {
  final OrderItemData item;

  const OrderItemCardWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final product = item.product;

    final imageUrl = product?.imgCover != null
        ? 'https://flower.elevateegy.com/uploads/${product!.imgCover}'
        : '';

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImageWidget(
              urlToImage: imageUrl,
              width: 64,
              height: 64,
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product?.title ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: getMediumStyle(
                    context: context,
                    fontSize: 14,
                    color: AppColors.textPrimary,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  '${TrackOrderConstants.qty}: '
                  '${item.quantity ?? 1}',
                  style: getRegularStyle(
                    context: context,
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          Text(
            '${CheckoutConstants.egp}'
            '${item.price?.toStringAsFixed(2) ?? '0.00'}',
            style: getSemiBoldStyle(
              context: context,
              fontSize: 14,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
