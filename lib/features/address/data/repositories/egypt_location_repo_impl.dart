import 'package:flower/features/address/data/datasources/egypt_location_local_data_source.dart';
import 'package:flower/features/address/domain/entities/location_item.dart';
import 'package:flower/features/address/domain/repositories/egypt_location_repo.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: EgyptLocationRepo)
class EgyptLocationRepoImpl implements EgyptLocationRepo {
  final EgyptLocationLocalDataSource _localDataSource;

  EgyptLocationRepoImpl(this._localDataSource);

  @override
  Future<List<CityItem>> getCities() => _localDataSource.loadCities();

  @override
  Future<List<AreaItem>> getAreas() => _localDataSource.loadAreas();
}
