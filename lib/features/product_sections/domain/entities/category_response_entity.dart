import 'package:flower/features/product_sections/domain/entities/category_entity.dart';
import 'package:flower/features/product_sections/domain/entities/meta_data_entity.dart';

class CategoriesResponseEntity {
  final String? message;

  final MetaDataEntity? metadata;

  final List<CategoryEntity>? categories;

  CategoriesResponseEntity({this.message, this.metadata, this.categories});
}
