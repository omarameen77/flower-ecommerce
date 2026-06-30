import 'package:flower/core/layout/app_size.dart';
import 'package:flower/core/localization_constants/checkout_constants.dart';
import 'package:flower/core/theme/app_colors.dart';
import 'package:flower/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';

class CheckoutGiftToggle extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const CheckoutGiftToggle({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSize.s16,
        vertical: AppSize.s4,
      ),
      decoration: BoxDecoration(color: AppColors.surface),
      child: SwitchListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(
          CheckoutConstants.sendAsGift,
          style: getMediumStyle(context: context, color: AppColors.textPrimary),
        ),
        activeTrackColor: AppColors.primary,
        value: value,
        onChanged: onChanged,
      ),
    );
  }
}
