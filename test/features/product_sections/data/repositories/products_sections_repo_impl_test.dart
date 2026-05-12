import 'package:flower/config/base/base_response.dart';
import 'package:flower/core/error/error_handler.dart';
import 'package:flower/features/product_sections/data/datasource/products_section_data_source_contract.dart';
import 'package:flower/features/product_sections/data/models/dtos/product_dto.dart';
import 'package:flower/features/product_sections/data/repositories/products_sections_repo_impl.dart';
import 'package:flower/features/product_sections/domain/entities/product_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'products_sections_repo_impl_test.mocks.dart';

@GenerateMocks([ProductsSectionDataSourceContract])
void main() {
  late MockProductsSectionDataSourceContract mockDataSource;
  late ProductsSectionsRepoImpl repo;

  late int limit;
  late String sort;

  setUpAll(() {
    limit = 8;
    sort = '-sold';

    provideDummy<BaseResponse<List<ProductDto>>>(
      SuccessBaseResponse<List<ProductDto>>(data: const []),
    );
  });

  setUp(() {
    mockDataSource = MockProductsSectionDataSourceContract();
    repo = ProductsSectionsRepoImpl(
      productsSectionDataSourceContract: mockDataSource,
    );
  });

  group('products sections repo impl', () {
    group('getProducts', () {
      test(
        'should map DTO list to entity list on success',
        () async {
          final dtos = [
            ProductDto(id: '1', title: 'Sunny', price: 600),
            ProductDto(id: '2', title: 'Red roses', price: 600),
          ];

          when(
            mockDataSource.getProducts(limit: limit, sort: sort),
          ).thenAnswer(
            (_) async => SuccessBaseResponse<List<ProductDto>>(data: dtos),
          );

          final result = await repo.getProducts(limit: limit, sort: sort);

          expect(result, isA<SuccessBaseResponse<List<ProductEntity>>>());
          final data =
              (result as SuccessBaseResponse<List<ProductEntity>>).data;
          expect(data, hasLength(2));
          expect(data.first.id, '1');
          expect(data.first.title, 'Sunny');
        },
      );

      test(
        'should preserve failure on error',
        () async {
          final failure = Failure(message: 'boom');
          when(
            mockDataSource.getProducts(limit: limit, sort: sort),
          ).thenAnswer(
            (_) async =>
                ErrorBaseResponse<List<ProductDto>>(failure: failure),
          );

          final result = await repo.getProducts(limit: limit, sort: sort);

          expect(result, isA<ErrorBaseResponse<List<ProductEntity>>>());
          expect(
            (result as ErrorBaseResponse<List<ProductEntity>>).failure,
            failure,
          );
        },
      );
    });
  });
}
