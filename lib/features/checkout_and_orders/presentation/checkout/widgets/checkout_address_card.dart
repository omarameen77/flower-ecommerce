import 'package:flower/core/layout/app_size.dart';
import 'package:flower/core/localization_constants/checkout_constants.dart';
import 'package:flower/core/resources/app_svgs.dart';
import 'package:flower/core/theme/app_colors.dart';
import 'package:flower/core/theme/app_text_style.dart';
import 'package:flower/core/widgets/app_sizebox.dart';
import 'package:flower/features/checkout_and_orders/presentation/checkout/cubit/checkout_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CheckoutAddressCard extends StatelessWidget {
  const CheckoutAddressCard({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CheckoutCubit>().state;

    return Container(
      padding: const EdgeInsets.all(AppSize.s16),
      decoration: BoxDecoration(color: AppColors.surface),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            CheckoutConstants.shippingAddress,
            style: getSemiBoldStyle(
              context: context,
              fontSize: AppSize.s15,
              color: AppColors.textPrimary,
            ),
          ),
          const AppSizedBox(height: AppSize.s12),
          Row(
            children: [
              SvgPicture.asset(AppSvgs.location),
              const AppSizedBox(width: AppSize.s8),
              Expanded(
                child: Text(
                  state.street,
                  style: getMediumStyle(
                    context: context,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  CheckoutConstants.addNewAddress,
                  style: getMediumStyle(
                    context: context,
                    color: AppColors.primary,
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
