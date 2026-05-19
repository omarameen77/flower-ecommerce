 
import 'package:flower/features/product_sections/domain/entities/product_entity.dart';
import 'package:flower/features/product_sections/presentation/home/home_design_token.dart';
import 'package:flower/features/product_sections/presentation/home/widgets/home_product_card.dart';
import 'package:flower/features/product_sections/presentation/home/widgets/home_product_card_shimmer.dart';
import 'package:flutter/material.dart';

class HorizontalProductsList extends StatelessWidget {
  final List<ProductEntity>? products;
  final bool isLoading;

  const HorizontalProductsList({
    super.key,
    required this.products,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    const listHeight =
        HomeTokens.productCardImageHeight + 60;

    if (isLoading) {
      return SizedBox(
        height: listHeight,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: 4,
          separatorBuilder: (_, _) =>
              const SizedBox(width: HomeTokens.sectionItemSpacing),
          itemBuilder: (_, _) => const HomeProductCardShimmer(),
        ),
      );
    }

    final items = products ?? [];
    if (items.isEmpty) return const SizedBox.shrink();

    return SizedBox(
      height: listHeight,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        separatorBuilder: (_, _) =>
            const SizedBox(width: HomeTokens.sectionItemSpacing),
        itemBuilder: (_, index) =>
            HomeProductCard(product: items[index]),
      ),
    );
  }
}