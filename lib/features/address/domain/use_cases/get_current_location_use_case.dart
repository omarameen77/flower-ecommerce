import 'package:flower/features/address/domain/entities/current_location.dart';
import 'package:flower/features/address/domain/repositories/current_location_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetCurrentLocationUseCase {
  final CurrentLocationRepo _repo;

  GetCurrentLocationUseCase(this._repo);

  Future<CurrentLocation> call() => _repo.getCurrent();
}
