import 'package:flower/config/base/base_response.dart';
import 'package:flower/features/product_sections/domain/entities/category_response_entity.dart';

abstract class CategoryRepoContract {
  Future<BaseResponse<CategoriesResponseEntity>> getCategories({int? limit});
}
