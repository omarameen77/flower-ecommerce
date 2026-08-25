import 'package:cached_network_image/cached_network_image.dart';
import 'package:flower/config/routes/routes.dart';
import 'package:flower/core/localization_constants/address_constants.dart';
import 'package:flower/core/localization_constants/cart_constants.dart';
import 'package:flower/core/localization_constants/general_constants.dart';
import 'package:flower/core/theme/app_colors.dart';
import 'package:flower/core/theme/app_text_style.dart';
import 'package:flower/core/widgets/app_sizebox.dart';
import 'package:flower/core/widgets/button_with_prefix.dart';
import 'package:flower/features/address/presentation/helpers/ensure_address_extension.dart';
import 'package:flower/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:flower/features/cart/presentation/cubit/cart_events.dart';
import 'package:flower/features/cart/presentation/cubit/cart_state.dart';
import 'package:flower/features/product_sections/domain/entities/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductWidget extends StatelessWidget {
  final ProductEntity product;

  const ProductWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final regularPrice = product.price ?? 0;
    final discountedPrice = product.priceAfterDiscount ?? regularPrice;
    final discount = product.discount ?? 0;

    final id = product.id;
    return GestureDetector(
      onTap: id == null
          ? null
          : () => Navigator.pushNamed(
              context,
              Routes.productDetails,
              arguments: id,
            ),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border),
        ),
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  imageUrl: product.imgCover ?? '',
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) => const ColoredBox(
                    color: AppColors.grey500,
                    child: Center(
                      child: Icon(
                        Icons.image_not_supported_outlined,
                        color: AppColors.grey800,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const AppSizedBox(height: 8),
            Text(
              product.title ?? GeneralConstants.noName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: getRegularStyle(
                context: context,
                color: AppColors.textPrimary,
                fontSize: 14,
              ),
            ),
            const AppSizedBox(height: 4),
            FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Text(
                    'EGP $discountedPrice',
                    style: getSemiBoldStyle(
                      context: context,
                      color: AppColors.textPrimary,
                      fontSize: 16,
                    ),
                  ),
                  const AppSizedBox(width: 6),
                  if (discount > 0) ...[
                    Text(
                      '$regularPrice',
                      style: getRegularStyle(
                        context: context,
                        color: AppColors.textSecondary,
                        fontSize: 13,
                      ).copyWith(decoration: TextDecoration.lineThrough),
                    ),
                    const AppSizedBox(width: 4),
                    Text(
                      '$discount%',
                      style: getRegularStyle(
                        context: context,
                        color: AppColors.success,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const AppSizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              height: 34,
              child: BlocBuilder<CartCubit, CartState>(
                buildWhen: (previous, current) =>
                    previous.loadingProducts != current.loadingProducts ||
                    previous.addedProducts != current.addedProducts,
                builder: (context, state) {
                  final productId = product.id;
                  final isLoading =
                      productId != null &&
                      state.loadingProducts.contains(productId);

                  final isAdded =
                      productId != null &&
                      state.addedProducts.contains(productId);

                  if (isLoading) {
                    return const Center(
                      child: SizedBox(
                        height: 18,
                        width: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    );
                  }

                  return ButtonWithPrefix(
                    text: isAdded
                        ? CartConstants.alreadyAdded
                        : CartConstants.addToCart,
                    onTap: productId != null && !isAdded
                        ? () async {
                            final hasAddress = await context
                                .ensureUserHasAddress(
                                  context.addAddressRequired,
                                );
                            if (!hasAddress || !context.mounted) return;
                            context.read<CartCubit>().onEvent(
                              AddToCartEvent(productId: productId, quantity: 1),
                            );
                          }
                        : null,

                    prefixIcon: Icon(
                      isAdded
                          ? Icons.check_circle
                          : Icons.shopping_cart_outlined,
                      size: 16,
                      color: AppColors.textWhite,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
