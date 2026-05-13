import 'package:flower/config/base/base_response.dart';
import 'package:flower/features/product_sections/data/datasource/products_section_data_source_contract.dart';
import 'package:flower/features/product_sections/domain/entities/occasion_entity.dart';
import 'package:flower/features/product_sections/domain/entities/product_entity.dart';
import 'package:flower/features/product_sections/domain/repositories/products_section_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProductsSectionRepo)
class ProductsSectionsRepoImpl implements ProductsSectionRepo {
  final ProductsSectionDataSourceContract productsSectionDataSourceContract;

  ProductsSectionsRepoImpl({required this.productsSectionDataSourceContract});
  @override
  Future<BaseResponse<List<OccasionEntity>>> getOccasions({
    int? limit,
    int? page,
  }) async {
    final response = await productsSectionDataSourceContract.getOccasions(
      limit: limit,
      page: page,
    );

  @override
  Future<BaseResponse<List<OccasionEntity>>> getOccasions({
    int? limit,
    int? page,
  }) async {
    final result = await productsSectionDataSourceContract.getOccasions(
      limit: limit,
      page: page,
    );
    switch (result) {
      case SuccessBaseResponse():
        return SuccessBaseResponse(
          data: result.data.map((dto) => dto.toDomain()).toList(),
        );
      case ErrorBaseResponse():
        return ErrorBaseResponse(failure: result.failure);
    }
  }

  @override
  Future<BaseResponse<List<ProductEntity>>> getProducts({
    int? limit,
    String? sort,
    String? categoryId,
    String? keyword,
  }) async {
    final result = await productsSectionDataSourceContract.getProducts(
      limit: limit,
      sort: sort,
      categoryId: categoryId,
      keyword: keyword,
    );
    switch (result) {
      case SuccessBaseResponse():
        return SuccessBaseResponse(
          data: result.data.map((dto) => dto.toDomain()).toList(),
        );
      case ErrorBaseResponse():
        return ErrorBaseResponse(failure: result.failure);
    }
  }
}
