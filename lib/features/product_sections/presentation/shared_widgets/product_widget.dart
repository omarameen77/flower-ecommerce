import 'package:cached_network_image/cached_network_image.dart';
import 'package:flower/core/theme/app_colors.dart';
import 'package:flower/core/theme/app_text_style.dart';
import 'package:flower/core/widgets/app_sizebox.dart';
import 'package:flower/core/widgets/button_with_prefix.dart';
import 'package:flower/features/product_sections/domain/entities/product_entity.dart';
import 'package:flutter/material.dart';

class ProductWidget extends StatelessWidget {
  final ProductEntity product;

  const ProductWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final regularPrice = product.price ?? 0;
    final discountedPrice = product.priceAfterDiscount ?? regularPrice;
    final discount = product.discount ?? 0;

    return Container(
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
            product.title ?? 'No name',
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
            child: ButtonWithPrefix(
              text: 'Add to cart',
              onTap: () {},
              prefixIcon: const Icon(
                Icons.shopping_cart_outlined,
                size: 16,
                color: AppColors.textWhite,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
