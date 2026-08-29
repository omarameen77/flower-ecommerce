part of 'category_products_cubit.dart';

sealed class CategoryProductsEvent extends Equatable {
  const CategoryProductsEvent();

  @override
  List<Object> get props => [];
}

class LoadInitialDataEvent extends CategoryProductsEvent {
  const LoadInitialDataEvent();

  @override
  List<Object> get props => [];
}

class RetryEvent extends CategoryProductsEvent {}

class SelectCategoryEvent extends CategoryProductsEvent {
  final int index;

  const SelectCategoryEvent(this.index);

  @override
  List<Object> get props => [index];
}

class HandleScrollEvent extends CategoryProductsEvent {
  final ScrollController scrollController;

  const HandleScrollEvent(this.scrollController);

  @override
  List<Object> get props => [scrollController];
}

class LoadMoreProductsEvent extends CategoryProductsEvent {}

class SearchProductsEvent extends CategoryProductsEvent {
  final String keyword;

  const SearchProductsEvent(this.keyword);

  @override
  List<Object> get props => [keyword];
}

class ClearSearchEvent extends CategoryProductsEvent {}
