part of 'occasions_products_cubit.dart';

sealed class OccasionsProductsEvent extends Equatable {
  const OccasionsProductsEvent();

  @override
  List<Object> get props => [];
}

class LoadInitialDataEvent extends OccasionsProductsEvent {
  final String? initialOccasionId;

  const LoadInitialDataEvent({this.initialOccasionId});

  @override
  List<Object> get props => [initialOccasionId ?? ''];
}

class RetryEvent extends OccasionsProductsEvent {}

class SelectOccasionEvent extends OccasionsProductsEvent {
  final int index;

  const SelectOccasionEvent(this.index);

  @override
  List<Object> get props => [index];
}

class HandleScrollEvent extends OccasionsProductsEvent {
  final ScrollController scrollController;

  const HandleScrollEvent(this.scrollController);

  @override
  List<Object> get props => [scrollController];
}

class LoadMoreProductsEvent extends OccasionsProductsEvent {}
