part of 'product_cubit.dart';

class ProductState extends Equatable {
  final BaseState<List<ProductEntity>> productBaseState;
  final int limit;
  final bool isLoadingMore;
  final String? currentSort;
  final String? currentCategoryId;

  const ProductState({
    this.productBaseState = const BaseState<List<ProductEntity>>(
      isLoading: false,
      data: [],
    ),
    this.limit = 8,
    this.isLoadingMore = false,
    this.currentSort,
    this.currentCategoryId,
  });

  ProductState copyWith({
    BaseState<List<ProductEntity>>? productBaseState,
    int? limit,
    bool? isLoadingMore,
    String? currentSort,
    String? currentCategoryId,
  }) {
    return ProductState(
      productBaseState: productBaseState ?? this.productBaseState,
      limit: limit ?? this.limit,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      currentSort: currentSort ?? this.currentSort,
      currentCategoryId: currentCategoryId ?? this.currentCategoryId,
    );
  }

  @override
  List<Object?> get props => [
    productBaseState,
    limit,
    isLoadingMore,
    currentSort,
    currentCategoryId,
  ];
}
