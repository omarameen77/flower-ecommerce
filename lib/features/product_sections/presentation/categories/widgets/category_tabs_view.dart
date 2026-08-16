import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flower/core/theme/app_colors.dart';
import 'package:flower/core/theme/app_text_style.dart';
import 'package:flower/core/widgets/app_sizebox.dart';
import 'package:flower/features/product_sections/domain/entities/category_entity.dart';
import 'package:flower/features/product_sections/presentation/categories/cubit/category_products_cubit.dart';
import 'package:flower/features/product_sections/presentation/categories/widgets/products_grid_by_category.dart';

class CategoryTabsView extends StatelessWidget {
  final List<CategoryEntity> categories;
  final ScrollController scrollController;

  const CategoryTabsView({
    super.key,
    required this.categories,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    final initialIndex = context
        .read<CategoryProductsCubit>()
        .state
        .selectedCategoryIndex;

    return DefaultTabController(
      length: categories.length,
      initialIndex: initialIndex,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TabBar(
            isScrollable: true,
            indicatorColor: AppColors.primary,
            labelColor: AppColors.primary,
            unselectedLabelColor: AppColors.textSecondary,
            labelStyle: getMediumStyle(
              context: context,
              color: AppColors.primary,
              fontSize: 14,
            ),
            unselectedLabelStyle: getRegularStyle(
              context: context,
              color: AppColors.textSecondary,
              fontSize: 16,
            ),
            dividerColor: AppColors.border,
            tabAlignment: TabAlignment.start,
            onTap: (index) => context.read<CategoryProductsCubit>().doEvent(
              SelectCategoryEvent(index),
            ),
            tabs: categories.map((category) {
              return Tab(text: category.name ?? 'Unknown');
            }).toList(),
          ),
          const AppSizedBox(height: 8),
          Expanded(
            child: TabBarView(
              children: categories.map((category) {
                return ProductsGridByCategory(
                  categoryId: category.id,
                  scrollController: scrollController,
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
