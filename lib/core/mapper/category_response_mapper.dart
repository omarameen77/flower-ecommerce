import 'package:flower/core/mapper/meta_data_mapper.dart';
import 'package:flower/features/product_sections/domain/entities/category_response_entity.dart';
import 'package:flower/features/product_sections/data/models/response/categories_response.dart';

extension CategoryResponseMapper on CategoriesResponse {
  CategoriesResponseEntity toDomain() {
    return CategoriesResponseEntity(
      message: message,
      metadata: metadata?.toDomain(),
      categories: categories?.map((e) => e.toDomain()).toList() ?? [],
    );
  }
}
