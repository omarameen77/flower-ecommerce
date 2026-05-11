import 'package:flower/config/base/base_response.dart';
import 'package:flower/features/product_sections/data/datasource/products_section_data_source_contract.dart';
import 'package:flower/features/product_sections/data/models/dtos/occasion_dto.dart';
import 'package:flower/features/product_sections/data/models/dtos/product_dto.dart';
import 'package:flower/features/product_sections/domain/entities/occasion_entity.dart';
import 'package:flower/features/product_sections/domain/entities/product_entity.dart';
import 'package:flower/features/product_sections/domain/repositories/products_section_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProductsSectionRepo)
class ProductsSectionsRepoImpl implements ProductsSectionRepo {
  final ProductsSectionDataSourceContract productsSectionDataSourceContract;

  ProductsSectionsRepoImpl({required this.productsSectionDataSourceContract});
  @override
  Future<BaseResponse<List<OccasionEntity>>> getOccasions({int? limit, int? page}) async {
    final response = await productsSectionDataSourceContract.getOccasions(limit: limit, page: page);

    switch (response) {
      case SuccessBaseResponse<List<OccasionDto>>():
        return SuccessBaseResponse<List<OccasionEntity>>(
          data: response.data.map((e) => e.toDomain()).toList(),
        );
      case ErrorBaseResponse<List<OccasionDto>>():
        return ErrorBaseResponse<List<OccasionEntity>>(
          failure: response.failure,
        );
    }
  }

  @override
  Future<BaseResponse<List<ProductEntity>>> getProducts({
    int? limit,
    String? sort,
  }) async {
    final response = await productsSectionDataSourceContract.getProducts(
      limit: limit,
      sort: sort,
    );

    switch (response) {
      case SuccessBaseResponse<List<ProductDto>>():
        return SuccessBaseResponse<List<ProductEntity>>(
          data: response.data.map((e) => e.toDomain()).toList(),
        );
      case ErrorBaseResponse<List<ProductDto>>():
        return ErrorBaseResponse<List<ProductEntity>>(
          failure: response.failure,
        );
    }
  }
}
