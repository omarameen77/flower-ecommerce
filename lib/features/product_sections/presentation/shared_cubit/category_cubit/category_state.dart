part of 'category_cubit.dart';

class CategoryState extends Equatable {
  final BaseState<List<CategoryEntity>> categoryBaseState;

  const CategoryState({
    this.categoryBaseState = const BaseState(isLoading: true, data: []),
  });

  CategoryState copyWith({BaseState<List<CategoryEntity>>? categoryBaseState}) {
    return CategoryState(
      categoryBaseState: categoryBaseState ?? this.categoryBaseState,
    );
  }

  @override
  List<Object?> get props => [categoryBaseState];
}
