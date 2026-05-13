part of 'search_cubit.dart';

class SearchState extends Equatable {
  final BaseState<List<ProductEntity>> productsState;
  final int limit;
  final bool isLoadingMore;
  final bool hasReachedMax;
  const SearchState({
    required this.productsState,
    this.limit = 20,
    this.isLoadingMore = false,
    this.hasReachedMax = false,
  });

  SearchState copyWith({
    BaseState<List<ProductEntity>>? productsState,
    int? limit,
    bool? isLoadingMore,
    bool? hasReachedMax,
  }) {
    return SearchState(
      productsState: productsState ?? this.productsState,
      limit: limit ?? this.limit,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object?> get props => [
    productsState,
    limit,
    isLoadingMore,
    hasReachedMax,
  ];
}
