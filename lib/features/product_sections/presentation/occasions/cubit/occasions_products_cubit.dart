import 'package:equatable/equatable.dart';
import 'package:flower/features/product_sections/domain/use_cases/get_occasions_use_case.dart';
import 'package:flower/features/product_sections/domain/use_cases/get_products_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flower/config/base/base_response.dart';
import 'package:flower/config/base/base_state.dart';
import 'package:flower/core/error/error_handler.dart';
import 'package:flower/features/product_sections/domain/entities/occasion_entity.dart';
import 'package:flower/features/product_sections/domain/entities/product_entity.dart';
import 'package:injectable/injectable.dart';

part 'occasions_products_event.dart';
part 'occasions_products_state.dart';

@injectable
class OccasionsProductsCubit extends Cubit<OccasionsProductsState> {
  final GetOccasionsUseCase getOccasionUseCase;
  final GetProductsUseCase getProductUseCase;

  OccasionsProductsCubit({
    required this.getOccasionUseCase,
    required this.getProductUseCase,
  }) : super(const OccasionsProductsState());

  void doEvent(OccasionsProductsEvent event) {
    switch (event) {
      case LoadInitialDataEvent():
        _loadInitialData(event.initialOccasionId);
        break;
      case RetryEvent():
        _retry();
        break;
      case SelectOccasionEvent():
        _selectOccasion(event.index);
        break;
      case HandleScrollEvent():
        _handleScroll(event.scrollController);
        break;
      case LoadMoreProductsEvent():
        _loadMoreProducts();
        break;
    }
  }

  Future<void> _loadInitialData(String? initialOccasionId) async {
    emit(
      state.copyWith(
        occasionsState: const BaseState(isLoading: true, data: []),
        productsState: const BaseState(isLoading: true, data: []),
        limit: OccasionsProductsState.initialLimit,
        isLoadingMore: false,
        selectedOccasionIndex: 0,
      ),
    );

    await _loadOccasions(initialOccasionId);
    await _loadProducts();
  }

  Future<void> _retry() async {
    doEvent(const LoadInitialDataEvent());
  }

  void _selectOccasion(int index) {
    if (index == state.selectedOccasionIndex) return;
    emit(state.copyWith(selectedOccasionIndex: index));
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
    await _loadProducts(loadMore: true);
  }

  List<ProductEntity> filteredProductsForOccasion(String occasionId) {
    final products = state.productsState.data;
    if (products == null || products.isEmpty) return [];
    return products.where((item) => item.occasion == occasionId).toList();
  }

  Future<void> _loadOccasions([String? initialOccasionId]) async {
    try {
      final result = await getOccasionUseCase.call();
      switch (result) {
        case SuccessBaseResponse<List<OccasionEntity>>():
          final occasions = result.data;
          int selectedIndex = 0;
          if (initialOccasionId != null && occasions.isNotEmpty) {
            final index = occasions.indexWhere(
              (o) => o.id == initialOccasionId,
            );
            if (index != -1) selectedIndex = index;
          } else if (occasions.isNotEmpty) {
            selectedIndex = state.selectedOccasionIndex.clamp(
              0,
              occasions.length - 1,
            );
          }

          emit(
            state.copyWith(
              occasionsState: BaseState(data: occasions),
              selectedOccasionIndex: selectedIndex,
            ),
          );
        case ErrorBaseResponse<List<OccasionEntity>>():
          emit(
            state.copyWith(
              occasionsState: BaseState(
                data: const [],
                errorMessage: result.failure.message,
              ),
            ),
          );
      }
    } catch (e) {
      emit(
        state.copyWith(
          occasionsState: BaseState(
            data: const [],
            errorMessage: ErrorHandler.handle(e).message,
          ),
        ),
      );
    }
  }

  Future<void> _loadProducts({bool loadMore = false}) async {
    try {
      if (loadMore && state.isLoadingMore) {
        return;
      }

      final currentProducts = state.productsState.data ?? [];
      final newLimit = loadMore
          ? state.limit + OccasionsProductsState.initialLimit
          : OccasionsProductsState.initialLimit;

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
}
