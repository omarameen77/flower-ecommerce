import 'package:flower/core/theme/app_colors.dart';
import 'package:flower/features/product_sections/domain/entities/category_entity.dart'; // تأكد من المسار
import 'package:flower/features/product_sections/presentation/shared_cubit/product_cubit/product_cubit.dart';
import 'package:flower/features/product_sections/presentation/shared_cubit/product_cubit/product_event.dart';
import 'package:flower/features/product_sections/presentation/shared_widgets/product_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ViewProductWidget extends StatelessWidget {
  final List<CategoryEntity> categories;

  const ViewProductWidget({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, productState) {
        if (productState.productBaseState.isLoading &&
            !productState.isLoadingMore) {
          return const Center(child: CircularProgressIndicator());
        }

        final products = productState.productBaseState.data ?? [];

        if (products.isEmpty) {
          return RefreshIndicator(
            onRefresh: () async {
              final currentIndex = DefaultTabController.of(context).index;

              context.read<ProductCubit>().doEvent(
                GetProductEvent(categoryId: categories[currentIndex].id),
              );
            },
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: const [
                SizedBox(height: 200),
                Center(
                  child: Text(
                    "No Products Found",
                    style: TextStyle(color: AppColors.grey700),
                  ),
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () async {
            final currentIndex = DefaultTabController.of(context).index;

            context.read<ProductCubit>().doEvent(
              GetProductEvent(categoryId: categories[currentIndex].id),
            );
          },
          child: GridView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) =>
                ProductWidget(product: products[index]),
          ),
        );
      },
    );
  }
}
