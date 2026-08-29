import 'package:flower/features/address/domain/entities/current_location.dart';

abstract interface class CurrentLocationRepo {
  Future<CurrentLocation> getCurrent();
}
