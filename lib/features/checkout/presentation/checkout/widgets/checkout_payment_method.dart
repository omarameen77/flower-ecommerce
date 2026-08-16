import 'package:flower/core/layout/app_size.dart';
import 'package:flower/core/localization_constants/checkout_constants.dart';
import 'package:flower/core/theme/app_colors.dart';
import 'package:flower/core/theme/app_text_style.dart';
import 'package:flower/core/widgets/app_sizebox.dart';
import 'package:flutter/material.dart';

class CheckoutPaymentMethod extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  const CheckoutPaymentMethod({
    super.key,
    required this.selectedIndex,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: AppColors.surface),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: AppSize.s16, top: AppSize.s16),
            child: Text(
              CheckoutConstants.paymentMethod,
              style: getSemiBoldStyle(
                context: context,
                fontSize: AppSize.s15,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          const AppSizedBox(height: AppSize.s10),
          _PaymentOption(
            index: 0,
            title: CheckoutConstants.cashOnDelivery,
            icon: Icons.money,
            isSelected: selectedIndex == 0,
            onTap: () => onChanged(0),
          ),
          const Divider(height: 1, color: AppColors.divider),
          _PaymentOption(
            index: 1,
            title: CheckoutConstants.creditCard,
            icon: Icons.credit_card,
            isSelected: selectedIndex == 1,
            onTap: () => onChanged(1),
          ),
        ],
      ),
    );
  }
}

class _PaymentOption extends StatelessWidget {
  final int index;
  final String title;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _PaymentOption({
    required this.index,
    required this.title,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSize.s16,
          vertical: AppSize.s14,
        ),
        child: Row(
          children: [
            Icon(icon, color: AppColors.primary, size: AppSize.s24),
            const AppSizedBox(width: AppSize.s12),
            Expanded(
              child: Text(
                title,
                style: getMediumStyle(
                  context: context,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            Icon(
              isSelected
                  ? Icons.radio_button_checked
                  : Icons.radio_button_unchecked,
              color: isSelected ? AppColors.primary : AppColors.grey700,
            ),
          ],
        ),
      ),
    );
  }
}
