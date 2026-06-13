import 'package:equatable/equatable.dart';

class CityItem extends Equatable {
  final String id;
  final String nameEn;
  final String nameAr;

  const CityItem({
    required this.id,
    required this.nameEn,
    required this.nameAr,
  });

  @override
  List<Object?> get props => [id, nameEn, nameAr];
}

class AreaItem extends Equatable {
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

  @override
  List<Object?> get props => [id, cityId, nameEn, nameAr];
}
