import 'package:equatable/equatable.dart';

sealed class ProductEvent extends Equatable {
  const ProductEvent();
}

class GetProductEvent extends ProductEvent {
  final bool loadMore;

  const GetProductEvent({this.loadMore = false});

  @override
  List<Object?> get props => [loadMore];
}