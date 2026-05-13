import 'package:equatable/equatable.dart';
import 'package:flower/config/base/base_response.dart';
import 'package:flower/config/base/base_state.dart';
import 'package:flower/features/product_sections/domain/entities/product_entity.dart';
import 'package:flower/features/product_sections/domain/use_cases/get_products_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final GetProductsUseCase getProductUseCase;

  SearchCubit(this.getProductUseCase)
    : super(const SearchState(productsState: BaseState(data: [])));

  String _currentKeyword = '';

  List<ProductEntity> _cachedProducts = [];

  Future<void> search(String keyword, {bool loadMore = false}) async {
    try {
      if (loadMore && state.isLoadingMore) return;

      _currentKeyword = keyword;

      final newLimit = loadMore ? state.limit + 20 : 20;

      if (!loadMore) {
        emit(
          state.copyWith(
            productsState: const BaseState(isLoading: true, data: []),
            limit: 20,
            isLoadingMore: false,
            hasReachedMax: false,
          ),
        );
      } else {
        emit(state.copyWith(isLoadingMore: true));
      }

      final result = await getProductUseCase.call(
        keyword: keyword,
        limit: newLimit,
      );

      switch (result) {
        case SuccessBaseResponse():
          final newProducts = result.data;

          final hasReachedMax =
              loadMore && newProducts.length == _cachedProducts.length;

          _cachedProducts = newProducts;

          emit(
            state.copyWith(
              productsState: BaseState(data: newProducts),
              limit: newLimit,
              isLoadingMore: false,
              hasReachedMax: hasReachedMax,
            ),
          );

        case ErrorBaseResponse():
          emit(
            state.copyWith(
              isLoadingMore: false,
              productsState: BaseState(
                errorMessage: result.failure.message,
                data: state.productsState.data,
              ),
            ),
          );
      }
    } catch (e) {
      emit(
        state.copyWith(
          isLoadingMore: false,
          productsState: BaseState(
            errorMessage: e.toString(),
            data: state.productsState.data,
          ),
        ),
      );
    }
  }

  void loadMore() {
    if (_currentKeyword.isEmpty || state.isLoadingMore || state.hasReachedMax) {
      return;
    }

    search(_currentKeyword, loadMore: true);
  }

  void clear() {
    _currentKeyword = '';

    _cachedProducts = [];

    emit(
      const SearchState(
        productsState: BaseState(data: []),
        limit: 20,
        isLoadingMore: false,
        hasReachedMax: false,
      ),
    );
  }
}
