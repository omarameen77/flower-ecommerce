import 'package:flower/config/base/base_response.dart';
import 'package:flower/features/product_sections/data/models/dtos/occasion_dto.dart';
import 'package:flower/features/product_sections/data/models/dtos/product_dto.dart';

abstract interface class ProductsSectionDataSourceContract {
  Future<BaseResponse<List<OccasionDto>>> getOccasions({int? limit, int? page});
  Future<BaseResponse<List<ProductDto>>> getProducts({
    int? limit,
    String? sort,
    String? categoryId,
    String? keyword,
  });
  Future<BaseResponse<ProductDto>> getProductById(String id);
}
