import 'package:flower/features/product_sections/domain/entities/meta_data_entity.dart';
import 'package:flower/features/product_sections/data/models/metadata/metadata_dto.dart';

extension MetaDataMapper on MetadataDto {
  MetaDataEntity toDomain() {
    return MetaDataEntity(
      currentPage: currentPage,
      limit: limit,
      totalItems: totalItems,
      totalPages: totalPages,
    );
  }
}
