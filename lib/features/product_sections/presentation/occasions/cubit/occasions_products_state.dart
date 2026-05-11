part of 'occasions_products_cubit.dart';

class OccasionsProductsState extends Equatable {
  final BaseState<List<OccasionEntity>> occasionsState;
  final BaseState<List<ProductEntity>> productsState;
  final int limit;
  final bool isLoadingMore;
  final int selectedOccasionIndex;

  static const int initialLimit = 20;

  const OccasionsProductsState({
    this.occasionsState = const BaseState<List<OccasionEntity>>(),
    this.productsState = const BaseState<List<ProductEntity>>(),
    this.limit = initialLimit,
    this.isLoadingMore = false,
    this.selectedOccasionIndex = 0,
  });

  bool get hasProducts =>
      productsState.data != null && productsState.data!.isNotEmpty;

  OccasionsProductsState copyWith({
    BaseState<List<OccasionEntity>>? occasionsState,
    BaseState<List<ProductEntity>>? productsState,
    int? limit,
    bool? isLoadingMore,
    int? selectedOccasionIndex,
  }) {
    return OccasionsProductsState(
      occasionsState: occasionsState ?? this.occasionsState,
      productsState: productsState ?? this.productsState,
      limit: limit ?? this.limit,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      selectedOccasionIndex:
          selectedOccasionIndex ?? this.selectedOccasionIndex,
    );
  }

  @override
  List<Object?> get props => [
    occasionsState,
    productsState,
    limit,
    isLoadingMore,
    selectedOccasionIndex,
  ];
}
