import 'dart:convert';

import 'package:flower/core/resources/app_strings.dart';
import 'package:flower/features/address/domain/entities/location_item.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:injectable/injectable.dart';

abstract interface class EgyptLocationLocalDataSource {
  Future<List<CityItem>> loadCities();
  Future<List<AreaItem>> loadAreas();
}

@LazySingleton(as: EgyptLocationLocalDataSource)
class EgyptLocationLocalDataSourceImpl implements EgyptLocationLocalDataSource {
  List<CityItem>? _citiesCache;
  List<AreaItem>? _areasCache;

  @override
  Future<List<CityItem>> loadCities() async {
    if (_citiesCache != null) return _citiesCache!;
    final raw = await rootBundle.loadString(AppStrings.governoratesAssetPath);
    final list = (jsonDecode(raw) as List).cast<Map<String, dynamic>>();
    _citiesCache = list.map(_cityFromJson).toList();
    return _citiesCache!;
  }

  @override
  Future<List<AreaItem>> loadAreas() async {
    if (_areasCache != null) return _areasCache!;
    final raw = await rootBundle.loadString(AppStrings.citiesAssetPath);
    final list = (jsonDecode(raw) as List).cast<Map<String, dynamic>>();
    _areasCache = list.map(_areaFromJson).toList();
    return _areasCache!;
  }

  CityItem _cityFromJson(Map<String, dynamic> json) => CityItem(
    id: json['id']?.toString() ?? '',
    nameEn: json['governorate_name_en']?.toString() ?? '',
    nameAr: json['governorate_name_ar']?.toString() ?? '',
  );

  AreaItem _areaFromJson(Map<String, dynamic> json) => AreaItem(
    id: json['id']?.toString() ?? '',
    cityId: json['governorate_id']?.toString() ?? '',
    nameEn: json['city_name_en']?.toString() ?? '',
    nameAr: json['city_name_ar']?.toString() ?? '',
  );
}
