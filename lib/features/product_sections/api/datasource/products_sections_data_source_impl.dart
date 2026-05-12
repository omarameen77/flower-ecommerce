import 'package:flower/config/base/base_response.dart';
import 'package:flower/core/error/error_handler.dart';
import 'package:flower/features/product_sections/api/api_client/products_sections_api_client.dart';
import 'package:flower/features/product_sections/data/datasource/products_section_data_source_contract.dart';
import 'package:flower/features/product_sections/data/models/dtos/occasion_dto.dart';
import 'package:flower/features/product_sections/data/models/dtos/product_dto.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProductsSectionDataSourceContract)
class ProductsSectionsDataSourceImpl
    implements ProductsSectionDataSourceContract {
  final ProductsSectionsApiClient productsSectionsApiClient;

  ProductsSectionsDataSourceImpl({required this.productsSectionsApiClient});
  @override
  Future<BaseResponse<List<OccasionDto>>> getOccasions({
    int? limit,
    int? page,
  }) async {
    try {
      final response = await productsSectionsApiClient.getOccasions(
        limit: limit,
        page: page,
      );
      return SuccessBaseResponse<List<OccasionDto>>(
        data: response.occasions ?? [],
      );
    } catch (e) {
      return ErrorBaseResponse<List<OccasionDto>>(
        failure: ErrorHandler.handle(e),
      );
    }
  }

  @override
  Future<BaseResponse<List<ProductDto>>> getProducts({
    int? limit,
    String? sort,
    String? categoryId,
    String? keyword,
  }) async {
    try {
      final response = await productsSectionsApiClient.getProducts(
        limit: limit,
        sort: sort,
        categoryId: categoryId,
        keyword: keyword,
      );
      return SuccessBaseResponse<List<ProductDto>>(
        data: response.products ?? [],
      );
    } catch (e) {
      return ErrorBaseResponse<List<ProductDto>>(
        failure: ErrorHandler.handle(e),
      );
    }
  }
}
