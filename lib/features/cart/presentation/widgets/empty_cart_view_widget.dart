import 'package:flower/core/layout/app_size.dart';
import 'package:flower/core/localization_constants/cart_constants.dart';
import 'package:flower/core/theme/app_colors.dart';
import 'package:flower/core/theme/app_text_style.dart';
import 'package:flower/core/widgets/app_sizebox.dart';
import 'package:flutter/material.dart';

class EmptyCartView extends StatelessWidget {
  const EmptyCartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.add_shopping_cart_outlined,
            size: AppSize.s70,
            color: AppColors.primary,
          ),
          const AppSizedBox(height: AppSize.s16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                CartConstants.emptyCart,
                style: getMediumStyle(
                  context: context,
                  color: AppColors.textPrimary,
                  fontSize: AppSize.s14,
                ),
              ),
              InkWell(
                onTap: () {},
                child: Text(
                  CartConstants.goShopping,
                  style: getSemiBoldStyle(
                    context: context,
                    color: AppColors.primary,
                    fontSize: AppSize.s14,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
