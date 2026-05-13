import 'package:flower/config/base/base_response.dart';
import 'package:flower/features/product_sections/domain/entities/occasion_entity.dart';
import 'package:flower/features/product_sections/domain/entities/product_entity.dart';

abstract interface class ProductsSectionRepo {
  Future<BaseResponse<List<OccasionEntity>>> getOccasions({
    int? limit,
    int? page,
  });
  Future<BaseResponse<List<ProductEntity>>> getProducts({
    int? limit,
    String? sort,
    String? categoryId,
    String? keyword,
  });
  Future<BaseResponse<ProductEntity>> getProductById(String id);
}
