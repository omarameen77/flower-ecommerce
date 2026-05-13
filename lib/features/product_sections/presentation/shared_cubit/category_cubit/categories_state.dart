part of 'categories_cubit.dart';

class CategoriesState extends Equatable {
  final BaseState<CategoriesResponseEntity> categoriesState;

  final int selectedCategoryIndex;

  const CategoriesState({
    this.categoriesState = const BaseState<CategoriesResponseEntity>(
      isLoading: false,
    ),
    this.selectedCategoryIndex = 0,
  });

  CategoriesState copyWith({
    BaseState<CategoriesResponseEntity>? categoriesState,
    int? selectedCategoryIndex,
  }) {
    return CategoriesState(
      categoriesState: categoriesState ?? this.categoriesState,
      selectedCategoryIndex:
          selectedCategoryIndex ?? this.selectedCategoryIndex,
    );
  }

  @override
  List<Object?> get props => [categoriesState, selectedCategoryIndex];
}
