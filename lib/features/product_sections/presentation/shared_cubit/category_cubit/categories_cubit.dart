import 'package:flower/config/base/base_response.dart';
import 'package:flower/config/base/base_state.dart';
import 'package:flower/features/product_sections/domain/entities/category_response_entity.dart';
import 'package:flower/features/product_sections/domain/use_cases/get_categories_use_case.dart';
import 'package:flower/features/product_sections/presentation/shared_cubit/category_cubit/categories_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:equatable/equatable.dart';

part 'categories_state.dart';

@lazySingleton
class CategoriesCubit extends Cubit<CategoriesState> {
  final GetCategoriesUseCase getCategoriesUseCase;

  CategoriesCubit({required this.getCategoriesUseCase})
    : super(const CategoriesState());

  void onEvent(CategoriesEvent event) {
    switch (event) {
      case GetCategoriesEvent():
        _getCategories();

      case ChangeSelectedCategoryEvent():
        _changeSelectedCategory(event.selectedIndex);
    }
  }

  Future<void> _getCategories() async {
    emit(state.copyWith(categoriesState: const BaseState(isLoading: true)));

    final response = await getCategoriesUseCase();

    switch (response) {
      case SuccessBaseResponse<CategoriesResponseEntity>():
        emit(state.copyWith(categoriesState: BaseState(data: response.data)));

      case ErrorBaseResponse<CategoriesResponseEntity>():
        emit(
          state.copyWith(
            categoriesState: BaseState(errorMessage: response.failure.message),
          ),
        );
    }
  }

  void _changeSelectedCategory(int index) {
    emit(state.copyWith(selectedCategoryIndex: index));
  }

  void resetToAll() {
    emit(state.copyWith(selectedCategoryIndex: 0));
  }
}
