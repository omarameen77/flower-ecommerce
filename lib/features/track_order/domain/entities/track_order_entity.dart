import 'tracking_status.dart';

class TrackOrderEntity {
  final String? orderId;
  final bool driverRequestedDelivery;
  final OrderData? order;
  final StoreData? store;
  final UserData? user;
  final TrackingStatus? state;

  TrackOrderEntity({
    this.orderId,
    this.driverRequestedDelivery = false,
    this.order,
    this.store,
    this.user,
    this.state,
  });

  factory TrackOrderEntity.fromMap(Map<String, dynamic> data) {
    return TrackOrderEntity(
      orderId: data['orderId'] as String?,
      driverRequestedDelivery: data['driverRequestedDelivery'] == true,
      order: data['order'] != null ? OrderData.fromMap(data['order'] as Map<String, dynamic>) : null,
      store: data['store'] != null ? StoreData.fromMap(data['store'] as Map<String, dynamic>) : null,
      user: data['user'] != null ? UserData.fromMap(data['user'] as Map<String, dynamic>) : null,
      state: TrackingStatus.fromString(data['state'] as String?),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (orderId != null) 'orderId': orderId,
      'driverRequestedDelivery': driverRequestedDelivery,
      if (order != null) 'order': order!.toMap(),
      if (store != null) 'store': store!.toMap(),
      if (user != null) 'user': user!.toMap(),
      if (state != null) 'state': state!.name,
    };
  }
}

class OrderData {
  final String? id;
  final String? createdAt;
  final String? updatedAt;
  final bool isDelivered;
  final bool isPaid;
  final String? orderNumber;
  final double? totalPrice;
  final String? paymentType;
  final String? shippingAddress;
  final TrackingStatus? state;
  final List<OrderItemData>? orderItems;

  OrderData({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.isDelivered = false,
    this.isPaid = false,
    this.orderNumber,
    this.totalPrice,
    this.paymentType,
    this.shippingAddress,
    this.state,
    this.orderItems,
  });

  factory OrderData.fromMap(Map<String, dynamic> data) {
    final items = data['orderItems'] as List<dynamic>?;
    return OrderData(
      id: data['id'] as String?,
      createdAt: data['createdAt'] as String?,
      updatedAt: data['updatedAt'] as String?,
      isDelivered: data['isDelivered'] == true,
      isPaid: data['isPaid'] == true,
      orderNumber: data['orderNumber'] as String?,
      totalPrice: (data['totalPrice'] as num?)?.toDouble(),
      paymentType: data['paymentType'] as String?,
      shippingAddress: data['shippingAddress'] as String?,
      state: TrackingStatus.fromString(data['state'] as String?),
      orderItems: items?.map((e) => OrderItemData.fromMap(e as Map<String, dynamic>)).toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      if (createdAt != null) 'createdAt': createdAt,
      if (updatedAt != null) 'updatedAt': updatedAt,
      'isDelivered': isDelivered,
      'isPaid': isPaid,
      if (orderNumber != null) 'orderNumber': orderNumber,
      if (totalPrice != null) 'totalPrice': totalPrice,
      if (paymentType != null) 'paymentType': paymentType,
      if (shippingAddress != null) 'shippingAddress': shippingAddress,
      if (state != null) 'state': state!.name,
      if (orderItems != null) 'orderItems': orderItems!.map((e) => e.toMap()).toList(),
    };
  }
}

class OrderItemData {
  final String? id;
  final double? price;
  final int? quantity;
  final ProductData? product;

  OrderItemData({this.id, this.price, this.quantity, this.product});

  factory OrderItemData.fromMap(Map<String, dynamic> data) {
    return OrderItemData(
      id: data['id'] as String?,
      price: (data['price'] as num?)?.toDouble(),
      quantity: (data['quantity'] as num?)?.toInt(),
      product: data['product'] != null ? ProductData.fromMap(data['product'] as Map<String, dynamic>) : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      if (price != null) 'price': price,
      if (quantity != null) 'quantity': quantity,
      if (product != null) 'product': product!.toMap(),
    };
  }
}

class ProductData {
  final String? id;
  final String? imgCover;
  final double? price;
  final String? title;

  ProductData({this.id, this.imgCover, this.price, this.title});

  factory ProductData.fromMap(Map<String, dynamic> data) {
    return ProductData(
      id: data['id'] as String?,
      imgCover: data['imgCover'] as String?,
      price: (data['price'] as num?)?.toDouble(),
      title: data['title'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      if (imgCover != null) 'imgCover': imgCover,
      if (price != null) 'price': price,
      if (title != null) 'title': title,
    };
  }
}

class StoreData {
  final String? address;
  final String? image;
  final String? lat;
  final String? long;
  final String? name;
  final String? phoneNumber;

  StoreData({this.address, this.image, this.lat, this.long, this.name, this.phoneNumber});

  factory StoreData.fromMap(Map<String, dynamic> data) {
    return StoreData(
      address: data['address'] as String?,
      image: data['image'] as String?,
      lat: data['lat'] as String?,
      long: data['long'] as String?,
      name: data['name'] as String?,
      phoneNumber: data['phoneNumber'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (address != null) 'address': address,
      if (image != null) 'image': image,
      if (lat != null) 'lat': lat,
      if (long != null) 'long': long,
      if (name != null) 'name': name,
      if (phoneNumber != null) 'phoneNumber': phoneNumber,
    };
  }
}

class UserData {
  final String? id;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? gender;
  final String? phone;
  final String? photo;
  final String? state;

  UserData({this.id, this.email, this.firstName, this.lastName, this.gender, this.phone, this.photo, this.state});

  factory UserData.fromMap(Map<String, dynamic> data) {
    return UserData(
      id: data['_id'] as String?,
      email: data['email'] as String?,
      firstName: data['firstName'] as String?,
      lastName: data['lastName'] as String?,
      gender: data['gender'] as String?,
      phone: data['phone'] as String?,
      photo: data['photo'] as String?,
      state: data['state'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) '_id': id,
      if (email != null) 'email': email,
      if (firstName != null) 'firstName': firstName,
      if (lastName != null) 'lastName': lastName,
      if (gender != null) 'gender': gender,
      if (phone != null) 'phone': phone,
      if (photo != null) 'photo': photo,
      if (state != null) 'state': state,
    };
  }
}
