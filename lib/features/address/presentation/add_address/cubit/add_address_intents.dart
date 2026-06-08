import 'package:flower/core/location_data/egypt_location_loader.dart';

sealed class AddAddressIntent {
  const AddAddressIntent();
}

class LoadLookupsIntent extends AddAddressIntent {
  const LoadLookupsIntent();
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
