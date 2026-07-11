import 'package:flower/core/localization_constants/track_order_constants.dart';
import 'package:flower/core/theme/app_colors.dart';
import 'package:flower/core/theme/app_text_style.dart';
import 'package:flower/core/widgets/cached_network_image.dart';
import 'package:flower/features/track_order/domain/entities/track_order_entity.dart';
import 'package:flutter/material.dart';

class StoreInfoWidget extends StatelessWidget {
  final StoreData store;

  const StoreInfoWidget({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
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
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImageWidget(
              urlToImage: store.image ?? '',
              width: 56,
              height: 56,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  store.name ?? TrackOrderConstants.store,
                  style: getSemiBoldStyle(context: context, fontSize: 14, color: AppColors.textPrimary),
                ),
                const SizedBox(height: 4),
                Text(
                  store.address ?? '',
                  style: getRegularStyle(context: context, fontSize: 12, color: AppColors.textSecondary),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
