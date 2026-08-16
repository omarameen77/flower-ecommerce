import 'package:flower/features/product_sections/presentation/shared_widgets/product_widget_shimmer.dart';
import 'package:flutter/material.dart';

class ProductsShimmerGrid extends StatelessWidget {
  final int itemCount;

  const ProductsShimmerGrid({super.key, required this.itemCount});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.63,
      ),
      itemCount: itemCount,
      itemBuilder: (context, _) => const ProductWidgetShimmer(),
    );
  }
}
