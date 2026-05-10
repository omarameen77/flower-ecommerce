import 'package:flower/config/base/base_response.dart';
import 'package:flower/features/product_sections/domain/entities/occasion_entity.dart';
import 'package:flower/features/product_sections/domain/repositories/products_section_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetOccasionUseCase {
  final ProductsSectionRepo productsSectionRepo;

  GetOccasionUseCase({required this.productsSectionRepo});

  Future<BaseResponse<List<OccasionEntity>>> call({int? limit}) async {
    return productsSectionRepo.getOccasions(limit: limit);
  }
}
