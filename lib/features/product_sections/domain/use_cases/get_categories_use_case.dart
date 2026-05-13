import 'package:flower/config/base/base_response.dart';
import 'package:flower/features/product_sections/domain/entities/category_response_entity.dart';
import 'package:flower/features/product_sections/domain/repositories/categories_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetCategoriesUseCase {
  final CategoryRepoContract repo;

  GetCategoriesUseCase({required this.repo});

  Future<BaseResponse<CategoriesResponseEntity>> call({int? limit}) {
    return repo.getCategories(limit: limit);
  }
}
