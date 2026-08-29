import 'package:equatable/equatable.dart';

class CurrentLocation extends Equatable {
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

  @override
  List<Object?> get props => [lat, long, granted];
}
