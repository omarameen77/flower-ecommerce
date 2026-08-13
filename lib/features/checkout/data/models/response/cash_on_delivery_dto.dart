import 'package:flower/features/checkout/domain/models/cash_on_delivery_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cash_on_delivery_dto.g.dart';

@JsonSerializable()
class CashOnDeliveryDto {
  @JsonKey(name: "error")
  String? error;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "order")
  Order? order;

  CashOnDeliveryDto({this.message, this.order});

  CashOnDeliveryModel toModel() => CashOnDeliveryModel(
    error: error,
    message: message,
    orderNumber: order?.orderNumber,
    paymentType: order?.paymentType,
    orderId: order?.id,
  );

  factory CashOnDeliveryDto.fromJson(Map<String, dynamic> json) =>
      _$CashOnDeliveryDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CashOnDeliveryDtoToJson(this);
}

@JsonSerializable()
class Order {
  @JsonKey(name: "user")
  String? user;
  @JsonKey(name: "orderItems")
  List<OrderItem>? orderItems;
  @JsonKey(name: "totalPrice")
  int? totalPrice;
  @JsonKey(name: "paymentType")
  String? paymentType;
  @JsonKey(name: "isPaid")
  bool? isPaid;
  @JsonKey(name: "isDelivered")
  bool? isDelivered;
  @JsonKey(name: "state")
  String? state;
  @JsonKey(name: "_id")
  String? id;
  @JsonKey(name: "createdAt")
  DateTime? createdAt;
  @JsonKey(name: "updatedAt")
  DateTime? updatedAt;
  @JsonKey(name: "orderNumber")
  String? orderNumber;
  @JsonKey(name: "__v")
  int? v;

  Order({
    this.user,
    this.orderItems,
    this.totalPrice,
    this.paymentType,
    this.isPaid,
    this.isDelivered,
    this.state,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.orderNumber,
    this.v,
  });

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);
}

@JsonSerializable()
class OrderItem {
  @JsonKey(name: "price")
  int? price;
  @JsonKey(name: "quantity")
  int? quantity;
  @JsonKey(name: "_id")
  String? id;

  OrderItem({this.price, this.quantity, this.id});

  factory OrderItem.fromJson(Map<String, dynamic> json) =>
      _$OrderItemFromJson(json);

  Map<String, dynamic> toJson() => _$OrderItemToJson(this);
}
