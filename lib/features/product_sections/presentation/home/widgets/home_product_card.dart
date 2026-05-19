 
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flower/core/theme/app_colors.dart';
import 'package:flower/core/theme/app_text_style.dart';
import 'package:flower/core/theme/font_size_manager.dart';
import 'package:flower/features/product_sections/domain/entities/product_entity.dart';
import 'package:flower/features/product_sections/presentation/home/home_design_token.dart';
import 'package:flutter/material.dart';

import 'package:flower/config/routes/routes.dart';

class HomeProductCard extends StatelessWidget {
  final ProductEntity product;

  const HomeProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final displayPrice = product.priceAfterDiscount ?? product.price;

    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          Routes.productDetails,
          arguments: product.id,
        );
      },
      child: SizedBox(
        width: HomeTokens.productCardWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(
                imageUrl: product.imgCover ?? '',
                width: HomeTokens.productCardWidth,
                height: HomeTokens.productCardImageHeight,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: AppColors.grey400,
                ),
                errorWidget: (context, url, error) => Container(
                  color: AppColors.grey400,
                  child: Icon(Icons.image_not_supported_outlined,
                      color: AppColors.grey700),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              product.title ?? '',
              style: getRegularStyle(
                context: context,
                fontSize: FontSizeManager.s14,
                color: AppColors.textPrimary,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 2),
            Text(
              '$displayPrice EGP',
              style: getSemiBoldStyle(
                context: context,
                fontSize: FontSizeManager.s14,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}