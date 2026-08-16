part of 'category_products_cubit.dart';

class CategoryProductsState extends Equatable {
  final BaseState<List<CategoryEntity>> categoriesState;
  final BaseState<List<ProductEntity>> productsState;
  final int limit;
  final bool isLoadingMore;
  final int selectedCategoryIndex;
  final String searchKeyword;
  final bool isSearching;

  static const int initialLimit = 20;

  const CategoryProductsState({
    this.categoriesState = const BaseState<List<CategoryEntity>>(),
    this.productsState = const BaseState<List<ProductEntity>>(),
    this.limit = initialLimit,
    this.isLoadingMore = false,
    this.selectedCategoryIndex = 0,
    this.searchKeyword = '',
    this.isSearching = false,
  });

  bool get hasProducts =>
      productsState.data != null && productsState.data!.isNotEmpty;

  bool get isSearchActive => searchKeyword.isNotEmpty;

  CategoryProductsState copyWith({
    BaseState<List<CategoryEntity>>? categoriesState,
    BaseState<List<ProductEntity>>? productsState,
    int? limit,
    bool? isLoadingMore,
    int? selectedCategoryIndex,
    String? searchKeyword,
    bool? isSearching,
  }) {
    return CategoryProductsState(
      categoriesState: categoriesState ?? this.categoriesState,
      productsState: productsState ?? this.productsState,
      limit: limit ?? this.limit,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      selectedCategoryIndex:
          selectedCategoryIndex ?? this.selectedCategoryIndex,
      searchKeyword: searchKeyword ?? this.searchKeyword,
      isSearching: isSearching ?? this.isSearching,
    );
  }

  @override
  List<Object?> get props => [
    categoriesState,
    productsState,
    limit,
    isLoadingMore,
    selectedCategoryIndex,
    searchKeyword,
    isSearching,
  ];
}
