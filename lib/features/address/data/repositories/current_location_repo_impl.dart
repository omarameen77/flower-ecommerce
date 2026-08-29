import 'package:flower/features/address/data/datasources/current_location_data_source.dart';
import 'package:flower/features/address/domain/entities/current_location.dart';
import 'package:flower/features/address/domain/repositories/current_location_repo.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: CurrentLocationRepo)
class CurrentLocationRepoImpl implements CurrentLocationRepo {
  final CurrentLocationDataSource _dataSource;

  CurrentLocationRepoImpl(this._dataSource);

  @override
  Future<CurrentLocation> getCurrent() => _dataSource.getCurrent();
}
