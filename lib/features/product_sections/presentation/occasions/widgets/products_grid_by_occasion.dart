import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flower/features/product_sections/presentation/occasions/cubit/occasions_products_cubit.dart';
import 'package:flower/features/product_sections/presentation/shared_widgets/product_widget.dart';
import 'package:flower/features/product_sections/presentation/shared_widgets/product_widget_shimmer.dart';
import 'package:flower/features/product_sections/presentation/occasions/widgets/occasion_error_view.dart';
import 'package:flower/features/product_sections/presentation/occasions/widgets/products_shimmer_grid.dart';

class ProductsGridByOccasion extends StatelessWidget {
  final String occasionId;
  final ScrollController scrollController;

  const ProductsGridByOccasion({
    super.key,
    required this.occasionId,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OccasionsProductsCubit, OccasionsProductsState>(
      buildWhen: (previous, current) =>
          previous.productsState != current.productsState ||
          previous.isLoadingMore != current.isLoadingMore,
      builder: (context, state) {
        final filteredProducts = context
            .read<OccasionsProductsCubit>()
            .filteredProductsForOccasion(occasionId);
        final isLoading = state.productsState.isLoading && !state.hasProducts;
        final errorMessage = state.productsState.errorMessage;
        final hasAnyProducts = state.hasProducts;

        if (isLoading) {
          return const ProductsShimmerGrid(itemCount: 6);
        }

        if (errorMessage != null && !hasAnyProducts) {
          return OccasionErrorView(
            message: errorMessage,
            onRetry: () =>
                context.read<OccasionsProductsCubit>().doEvent(RetryEvent()),
          );
        }

        if (filteredProducts.isEmpty) {
          return const Center(
            child: Text('No products for this occasion yet.'),
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
