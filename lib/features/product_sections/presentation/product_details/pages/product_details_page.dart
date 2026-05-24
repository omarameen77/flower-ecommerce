import 'package:flower/config/dependency_injection/di.dart';
import 'package:flower/core/layout/app_padding.dart';
import 'package:flower/core/layout/app_size.dart';
import 'package:flower/core/localization_constants/cart_constants.dart';
import 'package:flower/core/resources/app_strings.dart';
import 'package:flower/core/theme/app_colors.dart';
import 'package:flower/core/widgets/app_loading_widget.dart';
import 'package:flower/core/widgets/button_loading_widget.dart';
import 'package:flower/core/widgets/button_with_prefix.dart';
import 'package:flower/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:flower/features/cart/presentation/cubit/cart_events.dart';
import 'package:flower/features/cart/presentation/cubit/cart_state.dart';
import 'package:flower/features/product_sections/presentation/product_details/cubit/product_details_cubit.dart';
import 'package:flower/features/product_sections/presentation/product_details/cubit/product_details_event.dart';
import 'package:flower/features/product_sections/presentation/product_details/widgets/product_details_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsPage extends StatelessWidget {
  final String productId;

  const ProductDetailsPage({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          getIt<ProductDetailsCubit>()
            ..doEvent(GetProductDetailsEvent(productId)),
      child: Scaffold(
        body: Stack(
          children: [
            BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
              builder: (context, state) {
                final base = state.productBaseState;
                if (base.isLoading) return const AppLoadingWidget();
                if (base.errorMessage != null) {
                  return Center(child: Text(base.errorMessage!));
                }
                final product = base.data;
                if (product == null) {
                  return const Center(child: Text('Product not found'));
                }
                return ProductDetailsBody(product: product);
              },
            ),
            Positioned(
              top: MediaQuery.of(context).padding.top + AppSize.s8,
              left: AppPadding.p16,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppPadding.p16),
            child: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
              builder: (context, pdState) {
                final product = pdState.productBaseState.data;
                final productId = product?.id;

                return BlocBuilder<CartCubit, CartState>(
                  buildWhen: (previous, current) =>
                      previous.loadingProducts != current.loadingProducts ||
                      previous.addedProducts != current.addedProducts,
                  builder: (context, cartState) {
                    final isLoading =
                        productId != null &&
                        cartState.loadingProducts.contains(productId);
                    final isAdded =
                        productId != null &&
                        cartState.addedProducts.contains(productId);

                    if (isLoading) {
                      return const SizedBox(
                        height: 48,
                        child: Center(child: ButtonLoadingWidget()),
                      );
                    }

                    return ButtonWithPrefix(
                      text: isAdded
                          ? CartConstants.alreadyAdded
                          : AppStrings.addToCart,
                      onTap: productId != null && !isAdded
                          ? () {
                              context.read<CartCubit>().onEvent(
                                AddToCartEvent(
                                  productId: productId,
                                  quantity: 1,
                                ),
                              );
                            }
                          : null,
                      prefixIcon: const Icon(
                        Icons.shopping_cart_outlined,
                        size: AppSize.s18,
                        color: AppColors.textWhite,
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
