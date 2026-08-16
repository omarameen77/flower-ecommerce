import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flower/core/localization_constants/categories_constants.dart';
import 'package:flower/features/product_sections/presentation/categories/cubit/category_products_cubit.dart';
import 'package:flower/features/product_sections/presentation/shared_widgets/product_widget.dart';
import 'package:flower/features/product_sections/presentation/shared_widgets/product_widget_shimmer.dart';
import 'package:flower/features/product_sections/presentation/categories/widgets/category_error_view.dart';

class ProductsGridByCategory extends StatelessWidget {
  final String? categoryId;
  final ScrollController scrollController;

  const ProductsGridByCategory({
    super.key,
    required this.categoryId,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryProductsCubit, CategoryProductsState>(
      buildWhen: (previous, current) =>
          previous.productsState != current.productsState ||
          previous.isLoadingMore != current.isLoadingMore,
      builder: (context, state) {
        final filteredProducts = context
            .read<CategoryProductsCubit>()
            .filteredProductsForCategory(categoryId);
        final isLoading = state.productsState.isLoading && !state.hasProducts;
        final errorMessage = state.productsState.errorMessage;
        final hasAnyProducts = state.hasProducts;

        if (isLoading) {
          return GridView.builder(
            padding: const EdgeInsets.only(top: 8, bottom: 8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 0.63,
            ),
            itemCount: 6,
            itemBuilder: (context, _) => const ProductWidgetShimmer(),
          );
        }

        if (errorMessage != null && !hasAnyProducts) {
          return CategoryErrorView(
            message: errorMessage,
            onRetry: () =>
                context.read<CategoryProductsCubit>().doEvent(RetryEvent()),
          );
        }

        if (filteredProducts.isEmpty) {
          return Center(
            child: Text(
              CategoriesConstants.noProductsForCategory,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          );
        }

        return GridView.builder(
          controller: scrollController,
          padding: const EdgeInsets.only(top: 8, bottom: 8),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 0.63,
          ),
          itemCount: filteredProducts.length + (state.isLoadingMore ? 2 : 0),
          itemBuilder: (context, index) {
            if (index >= filteredProducts.length) {
              return const ProductWidgetShimmer();
            }
            return ProductWidget(product: filteredProducts[index]);
          },
        );
      },
    );
  }
}
