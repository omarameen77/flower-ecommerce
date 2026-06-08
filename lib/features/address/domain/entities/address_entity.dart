import 'package:equatable/equatable.dart';

class AddressEntity extends Equatable {
  final String id;
  final String street;
  final String phone;
  final String city;
  final String lat;
  final String long;
  final String username;

  const AddressEntity({
    required this.id,
    required this.street,
    required this.phone,
    required this.city,
    required this.lat,
    required this.long,
    required this.username,
  });

  @override
  List<Object?> get props => [id, street, phone, city, lat, long, username];
}
