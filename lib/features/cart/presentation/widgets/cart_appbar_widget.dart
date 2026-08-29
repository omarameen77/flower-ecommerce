import 'package:flower/core/layout/app_size.dart';
import 'package:flower/core/localization_constants/cart_constants.dart';
import 'package:flower/core/theme/app_colors.dart';
import 'package:flower/core/theme/app_text_style.dart';
import 'package:flower/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:flower/features/cart/presentation/cubit/cart_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CartAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.background,
      surfaceTintColor: AppColors.background,
      elevation: 0,
      automaticallyImplyLeading: false,
      centerTitle: false,
      titleSpacing: AppSize.s16,
      title: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          final count = state.cart?.numOfCartItems ?? 0;

          return Row(
            children: [
              Text(
                CartConstants.cart,
                style: getSemiBoldStyle(
                  context: context,
                  color: AppColors.textPrimary,
                  fontSize: AppSize.s20,
                ),
              ),

              const SizedBox(width: 6),

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '$count',
                  style: getMediumStyle(
                    context: context,
                    color: AppColors.primary,
                    fontSize: AppSize.s12,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
