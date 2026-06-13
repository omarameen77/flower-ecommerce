import 'package:flower/core/layout/app_size.dart';
import 'package:flower/core/localization_constants/checkout_constants.dart';
import 'package:flower/core/theme/app_colors.dart';
import 'package:flower/core/widgets/app_sizebox.dart';
import 'package:flower/core/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class CheckoutReceiverFields extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController phoneController;

  const CheckoutReceiverFields({
    super.key,
    required this.nameController,
    required this.phoneController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSize.s16),
      decoration: BoxDecoration(
        color: AppColors.surface,
      ),
      child: Column(
        children: [
          CustomTextField(
            labelText: CheckoutConstants.receiverName,
            controller: nameController,
            hintText: CheckoutConstants.receiverName,
          ),
          const AppSizedBox(height: AppSize.s12),
          CustomTextField(
            labelText: CheckoutConstants.receiverPhone,
            controller: phoneController,
            hintText: CheckoutConstants.receiverPhone,
            keyboardType: TextInputType.phone,
          ),
        ],
      ),
    );
  }
}
