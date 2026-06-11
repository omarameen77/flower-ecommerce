import 'package:flower/core/localization_constants/orders_constants.dart';
import 'package:flower/core/theme/app_colors.dart';
import 'package:flower/core/theme/app_text_style.dart';
import 'package:flower/core/theme/font_size_manager.dart';
import 'package:flower/features/checkout_and_orders/presentation/orders/cubit/orders_cubit.dart';
import 'package:flutter/material.dart';

class OrdersTabBar extends StatelessWidget {
  final OrdersTab selectedTab;
  final ValueChanged<OrdersTab> onTabSelected;

  const OrdersTabBar({
    super.key,
    required this.selectedTab,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _TabItem(
                label: OrdersConstants.active,
                isSelected: selectedTab == OrdersTab.active,
                onTap: () => onTabSelected(OrdersTab.active),
              ),
            ),
            Expanded(
              child: _TabItem(
                label: OrdersConstants.completed,
                isSelected: selectedTab == OrdersTab.completed,
                onTap: () => onTabSelected(OrdersTab.completed),
              ),
            ),
          ],
        ),
        Container(height: 1, color: AppColors.border),
      ],
    );
  }
}

class _TabItem extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _TabItem({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isSelected ? AppColors.primary : Colors.transparent,
              width: 2.5,
            ),
          ),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: getMediumStyle(
            context: context,
            fontSize: FontSizeManager.s16,
            color: isSelected ? AppColors.primary : AppColors.grey700,
          ),
        ),
      ),
    );
  }
}
