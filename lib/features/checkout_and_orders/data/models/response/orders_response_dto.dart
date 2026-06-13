import 'package:flower/features/checkout_and_orders/domain/models/order_model.dart';

class OrdersResponseDto {
  final String? message;
  final OrdersMetadataDto? metadata;
  final List<OrderDto>? orders;

  OrdersResponseDto({this.message, this.metadata, this.orders});

  factory OrdersResponseDto.fromJson(Map<String, dynamic> json) {
    return OrdersResponseDto(
      message: json['message'] as String?,
      metadata: json['metadata'] != null
          ? OrdersMetadataDto.fromJson(json['metadata'] as Map<String, dynamic>)
          : null,
      orders: (json['orders'] as List<dynamic>?)
          ?.map((e) => OrderDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class OrdersMetadataDto {
  final int? currentPage;
  final int? totalPages;
  final int? limit;
  final int? totalItems;

  OrdersMetadataDto({this.currentPage, this.totalPages, this.limit, this.totalItems});

  factory OrdersMetadataDto.fromJson(Map<String, dynamic> json) {
    return OrdersMetadataDto(
      currentPage: json['currentPage'] as int?,
      totalPages: json['totalPages'] as int?,
      limit: json['limit'] as int?,
      totalItems: json['totalItems'] as int?,
    );
  }
}

class OrderDto {
  final String? id;
  final String? user;
  final List<OrderItemDto>? orderItems;
  final int? totalPrice;
  final String? paymentType;
  final bool? isPaid;
  final bool? isDelivered;
  final String? state;
  final String? createdAt;
  final String? updatedAt;
  final String? orderNumber;
  final int? v;

  OrderDto({
    this.id,
    this.user,
    this.orderItems,
    this.totalPrice,
    this.paymentType,
    this.isPaid,
    this.isDelivered,
    this.state,
    this.createdAt,
    this.updatedAt,
    this.orderNumber,
    this.v,
  });

  factory OrderDto.fromJson(Map<String, dynamic> json) {
    return OrderDto(
      id: json['_id'] as String?,
      user: json['user'] as String?,
      orderItems: (json['orderItems'] as List<dynamic>?)
          ?.map((e) => OrderItemDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPrice: json['totalPrice'] as int?,
      paymentType: json['paymentType'] as String?,
      isPaid: json['isPaid'] as bool?,
      isDelivered: json['isDelivered'] as bool?,
      state: json['state'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      orderNumber: json['orderNumber'] as String?,
      v: json['__v'] as int?,
    );
  }

  OrderModel toModel() {
    final firstItem = orderItems?.isNotEmpty == true ? orderItems!.first : null;
    return OrderModel(
      id: id ?? '',
      orderNumber: orderNumber ?? '',
      totalPrice: totalPrice ?? 0,
      paymentType: paymentType ?? '',
      state: state ?? '',
      isPaid: isPaid ?? false,
      isDelivered: isDelivered ?? false,
      createdAt: createdAt ?? '',
      productTitle: firstItem?.product?.title ?? '',
      productImage: firstItem?.product?.imgCover ?? '',
      productPrice: firstItem?.product?.price ?? 0,
      quantity: firstItem?.quantity ?? 0,
    );
  }
}

class OrderItemDto {
  final ProductDto? product;
  final int? price;
  final int? quantity;
  final String? id;

  OrderItemDto({this.product, this.price, this.quantity, this.id});

  factory OrderItemDto.fromJson(Map<String, dynamic> json) {
    return OrderItemDto(
      product: json['product'] != null
          ? ProductDto.fromJson(json['product'] as Map<String, dynamic>)
          : null,
      price: json['price'] as int?,
      quantity: json['quantity'] as int?,
      id: json['_id'] as String?,
    );
  }
}

class ProductDto {
  final String? id;
  final String? title;
  final String? slug;
  final String? description;
  final String? imgCover;
  final List<String>? images;
  final int? price;
  final int? priceAfterDiscount;
  final int? discount;

  ProductDto({
    this.id,
    this.title,
    this.slug,
    this.description,
    this.imgCover,
    this.images,
    this.price,
    this.priceAfterDiscount,
    this.discount,
  });

  factory ProductDto.fromJson(Map<String, dynamic> json) {
    return ProductDto(
      id: json['_id'] as String?,
      title: json['title'] as String?,
      slug: json['slug'] as String?,
      description: json['description'] as String?,
      imgCover: json['imgCover'] as String?,
      images: (json['images'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      price: json['price'] as int?,
      priceAfterDiscount: json['priceAfterDiscount'] as int?,
      discount: json['discount'] as int?,
    );
  }
}
