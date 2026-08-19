import 'package:flower/core/layout/app_size.dart';
import 'package:flower/core/localization_constants/cart_constants.dart';
import 'package:flower/core/resources/app_lotie.dart';
import 'package:flower/core/theme/app_colors.dart';
import 'package:flower/core/theme/app_text_style.dart';
import 'package:flower/core/widgets/app_sizebox.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmptyCartView extends StatelessWidget {
  const EmptyCartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSize.s32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 150,
              child: Lottie.asset(
                AppLotie.emptyCart,
                fit: BoxFit.cover,
                repeat: true,
              ),
            ),

            const AppSizedBox(height: AppSize.s16),

            Text(
              CartConstants.emptyCart,
              textAlign: TextAlign.center,
              style: getSemiBoldStyle(
                context: context,
                color: AppColors.textPrimary,
                fontSize: AppSize.s16,
              ),
            ),

            const AppSizedBox(height: AppSize.s8),

            GestureDetector(
              onTap: () {},
              child: Text(
                CartConstants.goShopping,
                textAlign: TextAlign.center,
                style: getMediumStyle(
                  context: context,
                  color: AppColors.primary,
                  fontSize: AppSize.s14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
