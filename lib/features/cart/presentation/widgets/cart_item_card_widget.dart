import 'package:flower/core/layout/app_size.dart';
import 'package:flower/core/localization_constants/cart_constants.dart';
import 'package:flower/core/resources/app_svgs.dart';
import 'package:flower/core/theme/app_colors.dart';
import 'package:flower/core/theme/app_text_style.dart';
import 'package:flower/core/widgets/app_loading_widget.dart';
import 'package:flower/core/widgets/app_sizebox.dart';
import 'package:flower/core/widgets/cached_network_image.dart';
import 'package:flower/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:flower/features/cart/presentation/cubit/cart_events.dart';
import 'package:flower/features/cart/presentation/cubit/cart_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class CartItemCard extends StatelessWidget {
  final String itemId;

  const CartItemCard({super.key, required this.itemId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      buildWhen: (previous, current) =>
          previous.cart != current.cart ||
          previous.loadingProducts != current.loadingProducts ||
          previous.deletingCartItemIds != current.deletingCartItemIds,
      builder: (context, state) {
        final item = state.cart?.cart?.cartItems
            ?.where((e) => e.id == itemId)
            .toList()
            .firstOrNull;

        if (item == null) return const SizedBox();

        final isLoading = state.loadingProducts.contains(
          item.product?.id ?? '',
        );

        final isDeleting = state.deletingCartItemIds.contains(
          item.product?.id ?? '',
        );

        return AnimatedOpacity(
          duration: const Duration(milliseconds: 200),
          opacity: isDeleting ? 0.6 : 1,
          child: Container(
            constraints: const BoxConstraints(minHeight: 120),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.grey700),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CachedNetworkImageWidget(
                    urlToImage: item.product?.imgCover ?? CartConstants.empty,
                    height: AppSize.s100,
                    width: AppSize.s90,
                  ),
                ),
                const AppSizedBox(width: 12),

                Expanded(
                  child: SizedBox(
                    height: AppSize.s100,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                item.product?.title ?? CartConstants.empty,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: getMediumStyle(
                                  context: context,
                                  color: AppColors.textPrimary,
                                  fontSize: AppSize.s16,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            isDeleting
                                ? const Padding(
                                    padding: EdgeInsets.all(2),
                                    child: AppLoadingWidget(size: AppSize.s18),
                                  )
                                : GestureDetector(
                                    onTap: () {
                                      final productId = item.product?.id;
                                      if (productId == null) return;
                                      context.read<CartCubit>().onEvent(
                                        RemoveCartItemEvent(
                                          cartItemId: productId,
                                        ),
                                      );
                                    },
                                    child: SvgPicture.asset(AppSvgs.delete),
                                  ),
                          ],
                        ),
                        const SizedBox(height: 4),

                        Text(
                          item.product?.slug ?? CartConstants.empty,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: getRegularStyle(
                            context: context,
                            color: AppColors.textSecondary,
                            fontSize: AppSize.s14,
                          ),
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                '${CartConstants.egp}${item.product?.price ?? CartConstants.empty}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: getSemiBoldStyle(
                                  context: context,
                                  color: AppColors.textPrimary,
                                  fontSize: AppSize.s14,
                                ),
                              ),
                            ),

                            GestureDetector(
                              onTap: () {
                                final q = item.quantity ?? 1;
                                if (q <= 1) return;

                                final productId = item.product?.id;
                                if (productId == null) return;

                                context.read<CartCubit>().onEvent(
                                  UpdateCartQuantityEvent(
                                    quantity: q - 1,
                                    cartItemId: productId,
                                  ),
                                );
                              },
                              child: SvgPicture.asset(AppSvgs.minus),
                            ),

                            const AppSizedBox(width: AppSize.s8),

                            isLoading
                                ? AppLoadingWidget(size: AppSize.s16)
                                : Text(
                                    '${item.quantity ?? 1}',
                                    style: getSemiBoldStyle(
                                      context: context,
                                      color: AppColors.textPrimary,
                                      fontSize: AppSize.s14,
                                    ),
                                  ),
                            const AppSizedBox(width: AppSize.s8),
                            GestureDetector(
                              onTap: () {
                                final q = item.quantity ?? 1;
                                final productId = item.product?.id;
                                if (productId == null) return;
                                context.read<CartCubit>().onEvent(
                                  UpdateCartQuantityEvent(
                                    quantity: q + 1,
                                    cartItemId: productId,
                                  ),
                                );
                              },
                              child: SvgPicture.asset(AppSvgs.plus),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
