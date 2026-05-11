part of 'product_details_cubit.dart';

class ProductDetailsState extends Equatable {
  final BaseState<ProductEntity> productBaseState;

  const ProductDetailsState({
    this.productBaseState = const BaseState<ProductEntity>(),
  });

  ProductDetailsState copyWith({
    BaseState<ProductEntity>? productBaseState,
  }) {
    return ProductDetailsState(
      productBaseState: productBaseState ?? this.productBaseState,
    );
  }

  @override
  List<Object?> get props => [productBaseState];
}
