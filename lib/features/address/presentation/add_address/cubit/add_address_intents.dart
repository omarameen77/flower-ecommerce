import 'package:flower/features/address/domain/entities/address_entity.dart';
import 'package:flower/features/address/domain/entities/location_item.dart';

sealed class AddAddressIntent {
  const AddAddressIntent();
}

class LoadLookupsIntent extends AddAddressIntent {
  final AddressEntity? editAddress;
  const LoadLookupsIntent({this.editAddress});
}

class CitySelectedIntent extends AddAddressIntent {
  final CityItem city;
  const CitySelectedIntent(this.city);
}

class AreaSelectedIntent extends AddAddressIntent {
  final AreaItem area;
  const AreaSelectedIntent(this.area);
}

class LocationPickedIntent extends AddAddressIntent {
  final String lat;
  final String long;
  const LocationPickedIntent({required this.lat, required this.long});
}

class ResolveCurrentLocationIntent extends AddAddressIntent {
  const ResolveCurrentLocationIntent();
}

class SubmitAddAddressIntent extends AddAddressIntent {
  final String street;
  final String phone;
  final String username;
  final String? editingId;

  const SubmitAddAddressIntent({
    required this.street,
    required this.phone,
    required this.username,
    this.editingId,
  });
}
