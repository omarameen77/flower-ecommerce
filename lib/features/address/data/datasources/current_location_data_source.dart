import 'package:flower/features/address/domain/entities/current_location.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';

abstract interface class CurrentLocationDataSource {
  Future<CurrentLocation> getCurrent();
}

@LazySingleton(as: CurrentLocationDataSource)
class CurrentLocationDataSourceImpl implements CurrentLocationDataSource {
  @override
  Future<CurrentLocation> getCurrent() async {
    final servicesOn = await Geolocator.isLocationServiceEnabled();
    if (!servicesOn) return CurrentLocation.fallback;

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      return CurrentLocation.fallback;
    }

    try {
      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          timeLimit: Duration(seconds: 10),
        ),
      );
      return CurrentLocation(
        lat: position.latitude,
        long: position.longitude,
        granted: true,
      );
    } catch (_) {
      return CurrentLocation.fallback;
    }
  }
}
