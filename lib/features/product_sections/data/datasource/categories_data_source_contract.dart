import 'package:flower/config/base/base_response.dart';
import 'package:flower/features/product_sections/data/models/response/categories_response.dart';

abstract class CategoriesDataSourceContract {
  Future<BaseResponse<CategoriesResponse>> getCategories({int? limit});
}
