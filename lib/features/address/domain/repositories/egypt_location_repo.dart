import 'package:flower/features/address/domain/entities/location_item.dart';

abstract interface class EgyptLocationRepo {
  Future<List<CityItem>> getCities();
  Future<List<AreaItem>> getAreas();
}
