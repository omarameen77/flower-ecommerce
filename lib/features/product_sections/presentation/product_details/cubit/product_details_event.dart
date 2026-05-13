import 'package:equatable/equatable.dart';

sealed class ProductDetailsEvent extends Equatable {
  const ProductDetailsEvent();
}

class GetProductDetailsEvent extends ProductDetailsEvent {
  final String id;

  const GetProductDetailsEvent(this.id);

  @override
  List<Object?> get props => [id];
}
