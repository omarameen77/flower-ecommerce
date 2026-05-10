
part of 'product_cubit.dart';


class ProductState extends Equatable {
  final BaseState<List<ProductEntity>> productBaseState;
  final int limit;
  final bool isLoadingMore;

  const ProductState({
    this.productBaseState = const BaseState<List<ProductEntity>>(
      isLoading: false,
      data: [],
    ),
    this.limit = 8,
    this.isLoadingMore = false,
  });

  ProductState copyWith({
    BaseState<List<ProductEntity>>? productBaseState,
    int? limit,
    bool? isLoadingMore,
  }) {
    return ProductState(
      productBaseState: productBaseState ?? this.productBaseState,
      limit: limit ?? this.limit,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }

  @override
  List<Object?> get props => [
        productBaseState,
        limit,
        isLoadingMore,
      ];
}