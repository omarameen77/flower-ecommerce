import 'package:flower/core/localization_constants/track_order_constants.dart';
import 'package:flower/core/theme/app_colors.dart';
import 'package:flower/core/theme/app_text_style.dart';
import 'package:flower/features/track_order/domain/entities/track_order_entity.dart';
import 'package:flower/features/track_order/presentation/widgets/order_item_card_widget.dart';
import 'package:flutter/material.dart';

class OrderItemsWidget extends StatelessWidget {
  final List<OrderItemData> items;

  const OrderItemsWidget({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          TrackOrderConstants.orderItems,
          style: getSemiBoldStyle(context: context, fontSize: 16, color: AppColors.textPrimary),
        ),
        const SizedBox(height: 12),
        ...items.map((item) => OrderItemCardWidget(item: item)),
      ],
    );
  }
}
