import 'package:flower/features/address/domain/entities/location_item.dart';
import 'package:flower/features/address/domain/repositories/egypt_location_repo.dart';
import 'package:injectable/injectable.dart';

class LocationLookups {
  final List<CityItem> cities;
  final List<AreaItem> areas;

  const LocationLookups({required this.cities, required this.areas});
}

@injectable
class LoadLocationLookupsUseCase {
  final EgyptLocationRepo _repo;

  LoadLocationLookupsUseCase(this._repo);

  Future<LocationLookups> call() async {
    final cities = await _repo.getCities();
    final areas = await _repo.getAreas();
    return LocationLookups(cities: cities, areas: areas);
  }
}
