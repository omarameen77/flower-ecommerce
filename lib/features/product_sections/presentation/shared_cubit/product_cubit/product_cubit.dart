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
  List<ProductEntity> _cachedCategoryProducts = [];

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
        emit(
          state.copyWith(
            productBaseState: BaseState(
              isLoading: false,
              data: _cachedCategoryProducts,
            ),
            limit: 8,
            isLoadingMore: false,
          ),
        );
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

      final newLimit = loadMore ? state.limit + 8 : 8;

      if (!loadMore) {
        emit(
          state.copyWith(
            productBaseState: const BaseState(isLoading: true, data: []),
            limit: 8,
          ),
        );
      } else {
        emit(state.copyWith(isLoadingMore: true));
      }

      final effectiveSort = sort ?? state.currentSort;

      final result = await getProductUseCase.call(
        limit: newLimit,
        sort: effectiveSort,
        categoryId: categoryId,
        keyword: keyword,
      );

      switch (result) {
        case SuccessBaseResponse():
          _cachedCategoryProducts = result.data;

          emit(
            state.copyWith(
              productBaseState: BaseState(data: result.data),
              limit: newLimit,
              isLoadingMore: false,
              currentSort: effectiveSort,
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
}
