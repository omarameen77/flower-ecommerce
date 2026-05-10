import 'package:flower/config/base/base_response.dart';
import 'package:flower/features/product_sections/domain/entities/product_entity.dart';
import 'package:flower/features/product_sections/domain/repositories/products_section_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetProductUseCase {
  final ProductsSectionRepo productsSectionRepo;

  GetProductUseCase({required this.productsSectionRepo});

  Future<BaseResponse<List<ProductEntity>>> call({int? limit}) async {
    return productsSectionRepo.getProducts(limit: limit);
  }
}
