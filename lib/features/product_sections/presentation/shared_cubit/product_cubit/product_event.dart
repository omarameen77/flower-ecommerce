import 'package:equatable/equatable.dart';

sealed class ProductEvent extends Equatable {
  const ProductEvent();
}

class GetProductEvent extends ProductEvent {
  final bool loadMore;
  final String? categoryId;
  final String? keyword;
  const GetProductEvent({this.loadMore = false, this.categoryId, this.keyword});

  @override
  List<Object?> get props => [loadMore, categoryId, keyword];
}

class ClearProductsEvent extends ProductEvent {
  const ClearProductsEvent();

  @override
  List<Object?> get props => [];
}
