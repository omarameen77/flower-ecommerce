import 'package:flower/core/layout/app_padding.dart';
import 'package:flower/core/layout/app_size.dart';
import 'package:flower/core/theme/app_colors.dart';
import 'package:flower/core/theme/app_text_style.dart';
import 'package:flower/core/theme/font_size_manager.dart';
import 'package:flower/core/widgets/app_sizebox.dart';
import 'package:flower/features/product_sections/domain/entities/product_entity.dart';
import 'package:flower/features/product_sections/presentation/product_details/widgets/product_image_carousel.dart';
import 'package:flutter/material.dart';

class ProductDetailsBody extends StatelessWidget {
  final ProductEntity product;

  const ProductDetailsBody({super.key, required this.product});

  List<String> get _allImages {
    final cover = product.imgCover;
    final extra = product.images ?? const <String>[];
    if (cover != null && cover.isNotEmpty) return [cover, ...extra];
    return extra;
  }

  bool get _inStock => (product.quantity ?? 0) > 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProductImageCarousel(
            images: _allImages,
            height: MediaQuery.of(context).size.height * 0.45,
          ),
          const AppSizedBox(height: AppSize.s20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildPriceAndStatus(context),
                const AppSizedBox(height: AppSize.s4),
                Text(
                  'All prices include tax',
                  style: getRegularStyle(
                    context: context,
                    color: AppColors.textSecondary,
                    fontSize: FontSizeManager.s12,
                  ),
                ),
                const AppSizedBox(height: AppSize.s12),
                Text(
                  product.title ?? '',
                  style: getSemiBoldStyle(
                    context: context,
                    color: AppColors.textPrimary,
                    fontSize: FontSizeManager.s18,
                  ),
                ),
                const AppSizedBox(height: AppSize.s24),
                _buildSection(
                  context,
                  title: 'Description',
                  body: product.description ?? '—',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceAndStatus(BuildContext context) {
    final regularPrice = product.price ?? 0;
    final discountedPrice = product.priceAfterDiscount ?? regularPrice;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            'EGP $discountedPrice',
            overflow: TextOverflow.ellipsis,
            style: getSemiBoldStyle(
              context: context,
              color: AppColors.textPrimary,
              fontSize: FontSizeManager.s24,
            ),
          ),
        ),
        const AppSizedBox(width: AppSize.s8),
        Flexible(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Status: ',
                style: getMediumStyle(
                  context: context,
                  color: AppColors.textPrimary,
                  fontSize: FontSizeManager.s14,
                ),
              ),
              Flexible(
                child: Text(
                  _inStock ? 'In stock' : 'Out of stock',
                  overflow: TextOverflow.ellipsis,
                  style: getRegularStyle(
                    context: context,
                    color: _inStock ? AppColors.success : AppColors.error,
                    fontSize: FontSizeManager.s14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required String body,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: getSemiBoldStyle(
            context: context,
            color: AppColors.textPrimary,
            fontSize: FontSizeManager.s16,
          ),
        ),
        const AppSizedBox(height: AppSize.s8),
        Text(
          body,
          style: getRegularStyle(
            context: context,
            color: AppColors.textSecondary,
            fontSize: FontSizeManager.s14,
          ),
        ),
      ],
    );
  }
}
