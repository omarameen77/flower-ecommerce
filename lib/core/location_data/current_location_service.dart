import 'package:geolocator/geolocator.dart';

class CurrentLocation {
  final double lat;
  final double long;
  final bool granted;

  const CurrentLocation({
    required this.lat,
    required this.long,
    required this.granted,
  });

  static const fallback = CurrentLocation(
    lat: 30.0444,
    long: 31.2357,
    granted: false,
  );
}

class CurrentLocationService {
  CurrentLocationService._();

  static Future<CurrentLocation> getCurrent() async {
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
