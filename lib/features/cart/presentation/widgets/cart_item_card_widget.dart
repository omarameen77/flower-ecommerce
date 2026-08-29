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

        if (item == null) {
          return const SizedBox.shrink();
        }

        final productId = item.product?.id ?? '';

        final isLoading = state.loadingProducts.contains(productId);

        final isDeleting = state.deletingCartItemIds.contains(productId);

        return AnimatedOpacity(
          duration: const Duration(milliseconds: 200),
          opacity: isDeleting ? 0.55 : 1,
          child: Container(
            constraints: const BoxConstraints(minHeight: 112),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.035),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CachedNetworkImageWidget(
                    urlToImage: item.product?.imgCover ?? CartConstants.empty,
                    height: AppSize.s90,
                    width: AppSize.s85,
                  ),
                ),

                const AppSizedBox(width: 12),

                Expanded(
                  child: SizedBox(
                    height: AppSize.s90,
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
                                  fontSize: AppSize.s15,
                                ),
                              ),
                            ),

                            const SizedBox(width: 8),

                            if (isDeleting)
                              const Padding(
                                padding: EdgeInsets.all(2),
                                child: AppLoadingWidget(size: AppSize.s18),
                              )
                            else
                              GestureDetector(
                                onTap: () {
                                  if (productId.isEmpty) {
                                    return;
                                  }

                                  context.read<CartCubit>().onEvent(
                                    RemoveCartItemEvent(cartItemId: productId),
                                  );
                                },
                                child: SvgPicture.asset(
                                  AppSvgs.delete,
                                  width: 18,
                                  height: 18,
                                ),
                              ),
                          ],
                        ),

                        const SizedBox(height: 3),

                        Text(
                          item.product?.slug ?? CartConstants.empty,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: getRegularStyle(
                            context: context,
                            color: AppColors.textSecondary,
                            fontSize: AppSize.s12,
                          ),
                        ),

                        const Spacer(),

                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                '${CartConstants.egp}'
                                '${item.product?.price ?? CartConstants.empty}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: getSemiBoldStyle(
                                  context: context,
                                  color: AppColors.textPrimary,
                                  fontSize: AppSize.s14,
                                ),
                              ),
                            ),

                            _QuantityButton(
                              icon: AppSvgs.minus,
                              onTap: () {
                                final quantity = item.quantity ?? 1;

                                if (quantity <= 1) {
                                  return;
                                }

                                if (productId.isEmpty) {
                                  return;
                                }

                                context.read<CartCubit>().onEvent(
                                  UpdateCartQuantityEvent(
                                    quantity: quantity - 1,
                                    cartItemId: productId,
                                  ),
                                );
                              },
                            ),

                            const AppSizedBox(width: AppSize.s8),

                            isLoading
                                ? const AppLoadingWidget(size: AppSize.s16)
                                : Text(
                                    '${item.quantity ?? 1}',
                                    style: getSemiBoldStyle(
                                      context: context,
                                      color: AppColors.textPrimary,
                                      fontSize: AppSize.s14,
                                    ),
                                  ),

                            const AppSizedBox(width: AppSize.s8),

                            _QuantityButton(
                              icon: AppSvgs.plus,
                              onTap: () {
                                final quantity = item.quantity ?? 1;

                                if (productId.isEmpty) {
                                  return;
                                }

                                context.read<CartCubit>().onEvent(
                                  UpdateCartQuantityEvent(
                                    quantity: quantity + 1,
                                    cartItemId: productId,
                                  ),
                                );
                              },
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

class _QuantityButton extends StatelessWidget {
  final String icon;
  final VoidCallback onTap;

  const _QuantityButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(child: SvgPicture.asset(icon, width: 14, height: 14)),
      ),
    );
  }
}
