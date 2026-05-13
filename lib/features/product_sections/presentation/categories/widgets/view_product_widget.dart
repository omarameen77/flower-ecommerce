import 'package:flower/features/product_sections/domain/entities/category_entity.dart';
import 'package:flower/features/product_sections/presentation/shared_cubit/product_cubit/product_cubit.dart';
import 'package:flower/features/product_sections/presentation/shared_cubit/product_cubit/product_event.dart';
import 'package:flower/features/product_sections/presentation/shared_widgets/product_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ViewProductWidget extends StatefulWidget {
  final List<CategoryEntity> categories;

  const ViewProductWidget({super.key, required this.categories});

  @override
  State<ViewProductWidget> createState() => _ViewProductWidgetState();
}

class _ViewProductWidgetState extends State<ViewProductWidget> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        final currentIndex = DefaultTabController.of(context).index;

        context.read<ProductCubit>().doEvent(
          GetProductEvent(
            loadMore: true,
            categoryId: widget.categories[currentIndex].id,
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, productState) {
        if (productState.productBaseState.isLoading &&
            !productState.isLoadingMore) {
          return const Center(child: CircularProgressIndicator());
        }

        final products = productState.productBaseState.data ?? [];

        return RefreshIndicator(
          onRefresh: () async {
            final currentIndex = DefaultTabController.of(context).index;

            context.read<ProductCubit>().doEvent(
              GetProductEvent(categoryId: widget.categories[currentIndex].id),
            );
          },
          child: GridView.builder(
            controller: _scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: products.length + (productState.isLoadingMore ? 1 : 0),
            itemBuilder: (context, index) {
              if (index >= products.length) {
                return const Center(child: CircularProgressIndicator());
              }

              return ProductWidget(product: products[index]);
            },
          ),
        );
      },
    );
  }
}
