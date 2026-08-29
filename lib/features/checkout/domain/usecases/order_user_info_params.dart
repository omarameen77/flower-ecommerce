class OrderUserInfoParams {
  final String street;
  final String phone;
  final String city;
  final String lat;
  final String long;
  final String? userName;
  final String? userPhone;
  final String? userImage;

  OrderUserInfoParams({
    required this.street,
    required this.phone,
    required this.city,
    required this.lat,
    required this.long,
    this.userName,
    this.userPhone,
    this.userImage,
  });

  Map<String, dynamic> toMap() {
    return {
      'street': street,
      'phone': phone,
      'city': city,
      'lat': lat,
      'long': long,
      'userName': userName ?? '',
      'userPhone': userPhone ?? '',
      'userImage': userImage ?? '',
    };
  }
}
