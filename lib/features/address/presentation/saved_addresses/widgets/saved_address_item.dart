import 'package:flower/core/layout/app_size.dart';
import 'package:flower/core/theme/app_colors.dart';
import 'package:flower/core/theme/app_text_style.dart';
import 'package:flower/core/theme/font_size_manager.dart';
import 'package:flower/core/widgets/app_sizebox.dart';
import 'package:flower/features/address/domain/entities/address_entity.dart';
import 'package:flutter/material.dart';

class SavedAddressItem extends StatelessWidget {
  final AddressEntity address;
  final bool isDeleting;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const SavedAddressItem({
    super.key,
    required this.address,
    required this.isDeleting,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSize.s16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.location_on_outlined,
            color: AppColors.textPrimary,
            size: 22,
          ),
          const AppSizedBox(width: AppSize.s8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  address.city,
                  style: getSemiBoldStyle(
                    context: context,
                    color: AppColors.textPrimary,
                    fontSize: FontSizeManager.s16,
                  ),
                ),
                const AppSizedBox(height: AppSize.s4),
                Text(
                  address.street,
                  style: getRegularStyle(
                    context: context,
                    color: AppColors.textSecondary,
                    fontSize: FontSizeManager.s14,
                  ),
                ),
              ],
            ),
          ),
          if (isDeleting)
            const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: AppColors.error,
              ),
            )
          else
            IconButton(
              padding: EdgeInsets.zero,
              visualDensity: VisualDensity.compact,
              icon: const Icon(
                Icons.delete_outline,
                color: AppColors.error,
                size: 22,
              ),
              onPressed: onDelete,
            ),
          IconButton(
            padding: EdgeInsets.zero,
            visualDensity: VisualDensity.compact,
            icon: const Icon(
              Icons.edit_outlined,
              color: AppColors.textPrimary,
              size: 22,
            ),
            onPressed: onEdit,
          ),
        ],
      ),
    );
  }
}
