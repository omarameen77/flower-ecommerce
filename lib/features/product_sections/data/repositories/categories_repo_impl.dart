import 'package:flower/config/base/base_response.dart';
import 'package:flower/core/mapper/category_response_mapper.dart';
import 'package:flower/features/product_sections/data/datasource/categories_data_source_contract.dart';
import 'package:flower/features/product_sections/domain/entities/category_response_entity.dart';
import 'package:flower/features/product_sections/domain/repositories/categories_repo.dart';
import 'package:flower/features/product_sections/data/models/response/categories_response.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: CategoryRepoContract)
class CategoriesRepoImpl implements CategoryRepoContract {
  final CategoriesDataSourceContract dataSource;

  CategoriesRepoImpl({required this.dataSource});

  @override
  Future<BaseResponse<CategoriesResponseEntity>> getCategories({
    int? limit,
  }) async {
    final response = await dataSource.getCategories(limit: limit);

    switch (response) {
      case SuccessBaseResponse<CategoriesResponse>():
        return SuccessBaseResponse(data: response.data.toDomain());

      case ErrorBaseResponse<CategoriesResponse>():
        return ErrorBaseResponse(failure: response.failure);
    }
  }
}
