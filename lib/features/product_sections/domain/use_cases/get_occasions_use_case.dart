import 'package:flower/config/base/base_response.dart';
import 'package:flower/features/product_sections/domain/entities/occasion_entity.dart';
import 'package:flower/features/product_sections/domain/repositories/products_section_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetOccasionsUseCase {
  final ProductsSectionRepo productsSectionRepo;

  GetOccasionsUseCase({required this.productsSectionRepo});

  Future<BaseResponse<List<OccasionEntity>>> call({
    int? limit,
    int? page,
  }) async {
    return productsSectionRepo.getOccasions(limit: limit, page: page);
  }
}
