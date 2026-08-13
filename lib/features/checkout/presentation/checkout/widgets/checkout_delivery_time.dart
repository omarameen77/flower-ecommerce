import 'package:easy_localization/easy_localization.dart';
import 'package:flower/core/layout/app_size.dart';
import 'package:flower/core/localization_constants/checkout_constants.dart';
import 'package:flower/core/theme/app_colors.dart';
import 'package:flower/core/theme/app_text_style.dart';
import 'package:flower/core/widgets/app_sizebox.dart';
import 'package:flutter/material.dart';

class CheckoutDeliveryTime extends StatelessWidget {
  const CheckoutDeliveryTime({super.key});

  static const _enMonths = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  static const _arMonths = [
    'يناير',
    'فبراير',
    'مارس',
    'أبريل',
    'مايو',
    'يونيو',
    'يوليو',
    'أغسطس',
    'سبتمبر',
    'أكتوبر',
    'نوفمبر',
    'ديسمبر',
  ];

  String _formatDate(DateTime date, BuildContext context) {
    final locale = context.locale.toString();
    if (locale.startsWith('ar')) {
      return '${date.day} ${_arMonths[date.month - 1]}';
    }
    return '${date.day} ${_enMonths[date.month - 1]}';
  }

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final deliveryDate = today.add(const Duration(days: 4));
    final dateText =
        '${_formatDate(today, context)} - ${_formatDate(deliveryDate, context)}';

    return Container(
      padding: const EdgeInsets.all(AppSize.s16),
      decoration: BoxDecoration(color: AppColors.surface),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            CheckoutConstants.deliveryTime,
            style: getSemiBoldStyle(
              context: context,
              fontSize: AppSize.s15,
              color: AppColors.textPrimary,
            ),
          ),
          const AppSizedBox(height: AppSize.s12),
          Row(
            children: [
              const Icon(Icons.flash_on, color: AppColors.primary, size: 24),
              const SizedBox(width: 12),
              Text(
                CheckoutConstants.instant,
                style: getMediumStyle(
                  context: context,
                  color: AppColors.textPrimary,
                ),
              ),
              const AppSizedBox(width: AppSize.s12),
              Text(
                dateText,
                style: getRegularStyle(
                  context: context,
                  color: AppColors.primary,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
