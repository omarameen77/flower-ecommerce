import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flower/features/product_sections/domain/use_cases/get_categories_use_case.dart';
import 'package:flower/features/product_sections/domain/use_cases/get_products_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flower/config/base/base_response.dart';
import 'package:flower/config/base/base_state.dart';
import 'package:flower/core/error/error_handler.dart';
import 'package:flower/features/product_sections/domain/entities/category_entity.dart';
import 'package:flower/features/product_sections/domain/entities/product_entity.dart';
import 'package:injectable/injectable.dart';

part 'category_products_event.dart';
part 'category_products_state.dart';

@injectable
class CategoryProductsCubit extends Cubit<CategoryProductsState> {
  final GetCategoriesUseCase getCategoriesUseCase;
  final GetProductsUseCase getProductUseCase;

  Timer? _debounce;

  CategoryProductsCubit({
    required this.getCategoriesUseCase,
    required this.getProductUseCase,
  }) : super(const CategoryProductsState());

  void doEvent(CategoryProductsEvent event) {
    switch (event) {
      case LoadInitialDataEvent():
        _loadInitialData();
        break;
      case RetryEvent():
        _retry();
        break;
      case SelectCategoryEvent():
        _selectCategory(event.index);
        break;
      case HandleScrollEvent():
        _handleScroll(event.scrollController);
        break;
      case LoadMoreProductsEvent():
        _loadMoreProducts();
        break;
      case SearchProductsEvent():
        _searchProducts(event.keyword);
        break;
      case ClearSearchEvent():
        _clearSearch();
        break;
    }
  }

  Future<void> _loadInitialData() async {
    emit(
      state.copyWith(
        categoriesState: const BaseState(isLoading: true, data: []),
        productsState: const BaseState(isLoading: true, data: []),
        limit: CategoryProductsState.initialLimit,
        isLoadingMore: false,
        selectedCategoryIndex: 0,
        searchKeyword: '',
        isSearching: false,
      ),
    );

    await _loadCategories();
    await _loadProducts();
  }

  Future<void> _retry() async {
    if (state.isSearchActive) {
      _searchProducts(state.searchKeyword);
    } else {
      doEvent(const LoadInitialDataEvent());
    }
  }

  void _selectCategory(int index) {
    if (index == state.selectedCategoryIndex) return;
    emit(state.copyWith(selectedCategoryIndex: index));
  }

  void _handleScroll(ScrollController scrollController) {
    if (!scrollController.hasClients) return;
    if (state.productsState.isLoading || state.isLoadingMore) return;

    final threshold = scrollController.position.maxScrollExtent - 200;
    if (scrollController.position.pixels >= threshold) {
      doEvent(LoadMoreProductsEvent());
    }
  }

  Future<void> _loadMoreProducts() async {
    if (state.isSearchActive) {
      _searchProducts(state.searchKeyword, loadMore: true);
    } else {
      await _loadProducts(loadMore: true);
    }
  }

  void _searchProducts(String keyword, {bool loadMore = false}) {
    _debounce?.cancel();

    if (!loadMore) {
      if (keyword.trim().isEmpty) {
        _clearSearch();
        return;
      }

      emit(
        state.copyWith(
          searchKeyword: keyword.trim(),
          isSearching: true,
          productsState: const BaseState(isLoading: true, data: []),
          limit: CategoryProductsState.initialLimit,
          isLoadingMore: false,
        ),
      );

      _debounce = Timer(const Duration(milliseconds: 400), () async {
        await _fetchSearchProducts(keyword.trim(), loadMore: false);
      });
    } else {
      _fetchSearchProducts(keyword.trim(), loadMore: true);
    }
  }

  Future<void> _fetchSearchProducts(
    String keyword, {
    required bool loadMore,
  }) async {
    final currentProducts = state.productsState.data ?? [];
    try {
      if (loadMore && state.isLoadingMore) return;

      final newLimit = loadMore
          ? state.limit + CategoryProductsState.initialLimit
          : CategoryProductsState.initialLimit;

      if (loadMore) {
        emit(state.copyWith(isLoadingMore: true));
      }

      final result = await getProductUseCase.call(
        limit: newLimit,
        keyword: keyword,
      );

      switch (result) {
        case SuccessBaseResponse<List<ProductEntity>>():
          emit(
            state.copyWith(
              productsState: BaseState(data: result.data),
              limit: newLimit,
              isLoadingMore: false,
            ),
          );
        case ErrorBaseResponse<List<ProductEntity>>():
          emit(
            state.copyWith(
              productsState: BaseState(
                data: loadMore ? currentProducts : null,
                errorMessage: result.failure.message,
              ),
              isLoadingMore: false,
            ),
          );
      }
    } catch (e) {
      emit(
        state.copyWith(
          productsState: BaseState(
            data: loadMore ? currentProducts : null,
            errorMessage: ErrorHandler.handle(e).message,
          ),
          isLoadingMore: false,
        ),
      );
    }
  }

  void _clearSearch() {
    _debounce?.cancel();
    emit(state.copyWith(searchKeyword: '', isSearching: false));
    _loadProducts();
  }

  List<ProductEntity> filteredProductsForCategory(String? categoryId) {
    final products = state.productsState.data;
    if (products == null || products.isEmpty) return [];
    if (categoryId == null) return products;
    return products.where((item) => item.category == categoryId).toList();
  }

  Future<void> _loadCategories() async {
    try {
      final result = await getCategoriesUseCase.call();
      switch (result) {
        case SuccessBaseResponse():
          final categories = result.data.categories ?? [];
          emit(state.copyWith(categoriesState: BaseState(data: categories)));
        case ErrorBaseResponse():
          emit(
            state.copyWith(
              categoriesState: BaseState(
                data: const [],
                errorMessage: result.failure.message,
              ),
            ),
          );
      }
    } catch (e) {
      emit(
        state.copyWith(
          categoriesState: BaseState(
            data: const [],
            errorMessage: ErrorHandler.handle(e).message,
          ),
        ),
      );
    }
  }

  Future<void> _loadProducts({bool loadMore = false}) async {
    try {
      if (loadMore && state.isLoadingMore) return;

      final currentProducts = state.productsState.data ?? [];
      final newLimit = loadMore
          ? state.limit + CategoryProductsState.initialLimit
          : CategoryProductsState.initialLimit;

      if (!loadMore) {
        emit(
          state.copyWith(
            productsState: const BaseState(isLoading: true, data: []),
            limit: newLimit,
            isLoadingMore: false,
          ),
        );
      } else {
        emit(state.copyWith(isLoadingMore: true));
      }

      final result = await getProductUseCase.call(limit: newLimit);
      switch (result) {
        case SuccessBaseResponse<List<ProductEntity>>():
          emit(
            state.copyWith(
              productsState: BaseState(data: result.data),
              limit: newLimit,
              isLoadingMore: false,
            ),
          );
        case ErrorBaseResponse<List<ProductEntity>>():
          emit(
            state.copyWith(
              productsState: BaseState(
                data: currentProducts,
                errorMessage: result.failure.message,
              ),
              isLoadingMore: false,
            ),
          );
      }
    } catch (e) {
      emit(
        state.copyWith(
          productsState: BaseState(
            data: state.productsState.data,
            errorMessage: ErrorHandler.handle(e).message,
          ),
          isLoadingMore: false,
        ),
      );
    }
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}
