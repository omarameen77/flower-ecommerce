import 'package:flower/features/product_sections/domain/entities/product_entity.dart';

class CartItemEntity {
  ProductEntity? product;
  int? price;
  int? quantity;
  String? id;

  CartItemEntity({this.product, this.price, this.quantity, this.id});
}
