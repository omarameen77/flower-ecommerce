import 'package:flower/config/base/base_response.dart';
import 'package:flower/core/network/safe_api_caller.dart';
import 'package:flower/features/product_sections/data/datasource/categories_data_source_contract.dart';
import 'package:flower/features/product_sections/api/api_client/products_sections_api_client.dart';
import 'package:flower/features/product_sections/data/models/response/categories_response.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: CategoriesDataSourceContract)
class CategoriesDataSourceImpl implements CategoriesDataSourceContract {
  final ProductsSectionsApiClient apiClient;
  final SafeApiCaller call;

  CategoriesDataSourceImpl({required this.apiClient, required this.call});

  @override
  Future<BaseResponse<CategoriesResponse>> getCategories({int? limit}) async {
    return await call.safeCall<CategoriesResponse>(() async {
      return await apiClient.getCategories(limit: limit);
    });
  }
}
