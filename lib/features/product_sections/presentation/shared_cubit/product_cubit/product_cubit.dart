import 'package:flower/config/base/base_response.dart';
import 'package:flower/config/base/base_state.dart';
import 'package:flower/core/error/error_handler.dart';
import 'package:flower/features/product_sections/domain/entities/product_entity.dart';
import 'package:flower/features/product_sections/domain/use_cases/get_products_use_case.dart';
import 'package:flower/features/product_sections/presentation/shared_cubit/product_cubit/product_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'product_state.dart';

@injectable
class ProductCubit extends Cubit<ProductState> {
  final GetProductsUseCase getProductUseCase;

  /// Cache products for every category.
  ///
  /// null key = All Products
  /// categoryId = specific category
  final Map<String?, List<ProductEntity>> _categoryProductsCache = {};

  ProductCubit({required this.getProductUseCase}) : super(const ProductState());

  void doEvent(ProductEvent event) {
    switch (event) {
      case GetProductEvent():
        _getProducts(
          loadMore: event.loadMore,
          categoryId: event.categoryId,
          keyword: event.keyword,
          sort: event.sort,
        );
        break;

      case ClearProductsEvent():
        _clearProducts();
        break;
    }
  }

  Future<void> _getProducts({
    bool loadMore = false,
    String? categoryId,
    String? keyword,
    String? sort,
  }) async {
    try {
      if (loadMore && state.isLoadingMore) return;

      final effectiveSort = sort ?? state.currentSort;

      // CACHE

      if (!loadMore && keyword == null && sort == null) {
        final cachedProducts = _categoryProductsCache[categoryId];

        if (cachedProducts != null) {
          emit(
            state.copyWith(
              productBaseState: BaseState(
                data: cachedProducts,
                isLoading: false,
              ),
              limit: cachedProducts.length,
              isLoadingMore: false,
              currentCategoryId: categoryId,
            ),
          );

          return;
        }
      }

      // LOADING

      final newLimit = loadMore ? state.limit + 8 : 8;

      if (!loadMore) {
        emit(
          state.copyWith(
            productBaseState: const BaseState(isLoading: true, data: []),
            limit: 8,
            currentCategoryId: categoryId,
          ),
        );
      } else {
        emit(state.copyWith(isLoadingMore: true));
      }

      // API REQUEST

      final result = await getProductUseCase.call(
        limit: newLimit,
        sort: effectiveSort,
        categoryId: categoryId,
        keyword: keyword,
      );

      switch (result) {
        case SuccessBaseResponse():
          final products = result.data;

          // SAVE TO CACHE

          if (keyword == null && sort == null) {
            _categoryProductsCache[categoryId] = products;
          }

          // UPDATE STATE

          emit(
            state.copyWith(
              productBaseState: BaseState(data: products, isLoading: false),
              limit: newLimit,
              isLoadingMore: false,
              currentSort: effectiveSort,
              currentCategoryId: categoryId,
            ),
          );

        case ErrorBaseResponse():
          emit(
            state.copyWith(
              isLoadingMore: false,
              productBaseState: BaseState(
                errorMessage: result.failure.message,
                data: state.productBaseState.data,
              ),
            ),
          );
      }
    } catch (e) {
      emit(
        state.copyWith(
          isLoadingMore: false,
          productBaseState: BaseState(
            errorMessage: ErrorHandler.handle(e).message,
            data: state.productBaseState.data,
          ),
        ),
      );
    }
  }

  void _clearProducts() {
    final cachedProducts =
        _categoryProductsCache[state.currentCategoryId] ?? [];

    emit(
      state.copyWith(
        productBaseState: BaseState(isLoading: false, data: cachedProducts),
        limit: cachedProducts.length,
        isLoadingMore: false,
      ),
    );
  }

  /// Optional: call this if you ever need to force refresh
  /// all category products.
  void clearCategoryCache() {
    _categoryProductsCache.clear();
  }

  /// Optional: remove cache for one category only.
  void clearCategoryCacheById(String? categoryId) {
    _categoryProductsCache.remove(categoryId);
  }
}
