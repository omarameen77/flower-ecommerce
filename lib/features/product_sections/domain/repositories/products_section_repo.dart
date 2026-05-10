import 'package:flower/config/base/base_response.dart';
import 'package:flower/features/product_sections/domain/entities/occasion_entity.dart';
import 'package:flower/features/product_sections/domain/entities/product_entity.dart';

abstract interface class ProductsSectionRepo {
  Future<BaseResponse<List<OccasionEntity>>> getOccasions({int? limit});
  Future<BaseResponse<List<ProductEntity>>> getProducts({int? limit});
}
