class OrderModel {
  final String id;
  final String orderNumber;
  final int totalPrice;
  final String paymentType;
  final String state;
  final bool isPaid;
  final bool isDelivered;
  final String createdAt;
  final String productTitle;
  final String productImage;
  final int productPrice;
  final int quantity;

  OrderModel({
    required this.id,
    required this.orderNumber,
    required this.totalPrice,
    required this.paymentType,
    required this.state,
    required this.isPaid,
    required this.isDelivered,
    required this.createdAt,
    required this.productTitle,
    required this.productImage,
    required this.productPrice,
    required this.quantity,
  });
}
