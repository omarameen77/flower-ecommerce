import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class CityItem {
  final String id;
  final String nameEn;
  final String nameAr;

  const CityItem({
    required this.id,
    required this.nameEn,
    required this.nameAr,
  });
}

class AreaItem {
  final String id;
  final String cityId;
  final String nameEn;
  final String nameAr;

  const AreaItem({
    required this.id,
    required this.cityId,
    required this.nameEn,
    required this.nameAr,
  });
}

class EgyptLocationLoader {
  EgyptLocationLoader._();

  static List<CityItem>? _citiesCache;
  static List<AreaItem>? _areasCache;

  static Future<List<CityItem>> loadCities() async {
    if (_citiesCache != null) return _citiesCache!;
    final raw = await rootBundle.loadString('assets/data/governorates.json');
    final list = (jsonDecode(raw) as List).cast<Map<String, dynamic>>();
    _citiesCache = list
        .map(
          (m) => CityItem(
            id: m['id']?.toString() ?? '',
            nameEn: m['governorate_name_en']?.toString() ?? '',
            nameAr: m['governorate_name_ar']?.toString() ?? '',
          ),
        )
        .toList();
    return _citiesCache!;
  }

  static Future<List<AreaItem>> loadAreas() async {
    if (_areasCache != null) return _areasCache!;
    final raw = await rootBundle.loadString('assets/data/cities.json');
    final list = (jsonDecode(raw) as List).cast<Map<String, dynamic>>();
    _areasCache = list
        .map(
          (m) => AreaItem(
            id: m['id']?.toString() ?? '',
            cityId: m['governorate_id']?.toString() ?? '',
            nameEn: m['city_name_en']?.toString() ?? '',
            nameAr: m['city_name_ar']?.toString() ?? '',
          ),
        )
        .toList();
    return _areasCache!;
  }
}
