import 'package:flower/core/layout/app_padding.dart';
import 'package:flower/core/layout/app_size.dart';
import 'package:flower/core/theme/app_colors.dart';
import 'package:flower/core/theme/app_text_style.dart';
import 'package:flower/core/widgets/app_sizebox.dart';
import 'package:flower/core/widgets/primary_button.dart';
import 'package:flower/features/product_sections/domain/entities/product_entity.dart';
import 'package:flower/features/product_sections/presentation/shared_cubit/product_cubit/product_cubit.dart';
import 'package:flower/features/product_sections/presentation/shared_cubit/product_cubit/product_event.dart';
import 'package:flower/features/product_sections/presentation/shared_widgets/product_widget.dart';
import 'package:flower/features/product_sections/presentation/shared_widgets/product_widget_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BestSellersGrid extends StatefulWidget {
  const BestSellersGrid({super.key});

  @override
  State<BestSellersGrid> createState() => _BestSellersGridState();
}

class _BestSellersGridState extends State<BestSellersGrid> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    final position = _scrollController.position;
    if (position.pixels >= position.maxScrollExtent - 200) {
      context.read<ProductCubit>().doEvent(
        const GetProductEvent(loadMore: true),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        final base = state.productBaseState;
        if (base.isLoading && (base.data?.isEmpty ?? true)) {
          return _buildShimmer();
        }
        final products = base.data ?? const <ProductEntity>[];
        if (products.isEmpty) {
          return _buildEmptyOrError(context, base.errorMessage);
        }
        return _buildGrid(products, state.isLoadingMore);
      },
    );
  }

  GridView _buildShimmer() {
    return GridView.builder(
      padding: const EdgeInsets.all(AppPadding.p16),
      gridDelegate: _gridDelegate,
      itemCount: 6,
      itemBuilder: (_, _) => const ProductWidgetShimmer(),
    );
  }

  GridView _buildGrid(List<ProductEntity> products, bool isLoadingMore) {
    return GridView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(AppPadding.p16),
      gridDelegate: _gridDelegate,
      itemCount: products.length + (isLoadingMore ? 2 : 0),
      itemBuilder: (_, i) {
        if (i >= products.length) return const ProductWidgetShimmer();
        return ProductWidget(product: products[i]);
      },
    );
  }

  Widget _buildEmptyOrError(BuildContext context, String? errorMessage) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              errorMessage ?? 'No products',
              textAlign: TextAlign.center,
              style: getRegularStyle(
                context: context,
                color: AppColors.textSecondary,
              ),
            ),
            const AppSizedBox(height: AppSize.s16),
            PrimaryButton(
              text: 'Retry',
              onTap: () => context.read<ProductCubit>().doEvent(
                const GetProductEvent(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static const _gridDelegate = SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    crossAxisSpacing: AppSize.s12,
    mainAxisSpacing: AppSize.s12,
    childAspectRatio: 0.62,
  );
}
