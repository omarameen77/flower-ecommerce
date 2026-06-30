import 'package:equatable/equatable.dart';

class AddressParams extends Equatable {
  final String street;
  final String phone;
  final String city;
  final String lat;
  final String long;
  final String username;

  const AddressParams({
    required this.street,
    required this.phone,
    required this.city,
    required this.lat,
    required this.long,
    required this.username,
  });

  @override
  List<Object?> get props => [street, phone, city, lat, long, username];
}
