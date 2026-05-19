import 'package:cached_network_image/cached_network_image.dart';
import 'package:flower/core/theme/app_colors.dart';
import 'package:flower/core/theme/app_text_style.dart';
import 'package:flower/core/theme/font_size_manager.dart';
import 'package:flower/features/product_sections/domain/entities/category_entity.dart';
import 'package:flower/features/product_sections/presentation/home/home_design_token.dart';
import 'package:flutter/material.dart';

import 'package:flower/features/app_sections/presentation/cubit/app_sections_cubit.dart';
import 'package:flower/features/product_sections/presentation/shared_cubit/category_cubit/categories_cubit.dart';
import 'package:flower/features/product_sections/presentation/shared_cubit/category_cubit/categories_event.dart';
import 'package:flower/features/product_sections/presentation/shared_cubit/product_cubit/product_cubit.dart';
import 'package:flower/features/product_sections/presentation/shared_cubit/product_cubit/product_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryItem extends StatelessWidget {
  final CategoryEntity category;

  const CategoryItem({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // 1. Switch to category tab
        context.read<AppSectionsCubit>().changeSection(1);

        // 2. Select this category in the categories list
        final categoriesCubit = context.read<CategoriesCubit>();
        final categories =
            categoriesCubit.state.categoriesState.data?.categories ?? [];
        final index = categories.indexWhere((c) => c.id == category.id);
        if (index != -1) {
          categoriesCubit.onEvent(ChangeSelectedCategoryEvent(index + 1));
        }

        // 3. Filter products by this category
        context.read<ProductCubit>().doEvent(
          GetProductEvent(categoryId: category.id),
        );
      },
      child: SizedBox(
        width: HomeTokens.categoryItemWidth,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: HomeTokens.widthCategoryIconBoxSize,
              height: HomeTokens.heightCategoryIconBoxSize,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.07),
                borderRadius: BorderRadius.circular(22),
              ),
              child: Center(
                child: SizedBox(
                  width: 25,
                  height: 25,
                  child: CachedNetworkImage(
                    imageUrl: category.image ?? '',
                    fit: BoxFit.contain,
                    placeholder: (context, url) => const SizedBox(),
                    errorWidget: (context, url, error) => Icon(
                      Icons.category_outlined,
                      color: AppColors.primary,
                      size: 18,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              category.name ?? '',
              style: getRegularStyle(
                context: context,
                fontSize: FontSizeManager.s14,
                color: AppColors.textPrimary,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
