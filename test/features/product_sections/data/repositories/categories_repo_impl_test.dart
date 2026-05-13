import 'package:flower/config/base/base_response.dart';
import 'package:flower/core/error/error_handler.dart';
import 'package:flower/features/product_sections/data/datasource/categories_data_source_contract.dart';
import 'package:flower/features/product_sections/data/models/response/categories_response.dart';
import 'package:flower/features/product_sections/domain/entities/category_response_entity.dart';
import 'package:flower/features/product_sections/data/repositories/categories_repo_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'categories_repo_impl_test.mocks.dart';

@GenerateMocks([CategoriesDataSourceContract])
void main() {
  late MockCategoriesDataSourceContract mockDataSource;
  late CategoriesRepoImpl repo;

  setUpAll(() {
    provideDummy<BaseResponse<CategoriesResponse>>(
      SuccessBaseResponse(data: CategoriesResponse(categories: [])),
    );

    provideDummy<BaseResponse<CategoriesResponseEntity>>(
      SuccessBaseResponse(data: CategoriesResponseEntity(categories: [])),
    );
  });

  setUp(() {
    mockDataSource = MockCategoriesDataSourceContract();
    repo = CategoriesRepoImpl(dataSource: mockDataSource);
  });

  group('Repo', () {
    test('success', () async {
      final response = CategoriesResponse(categories: []);

      when(
        mockDataSource.getCategories(limit: anyNamed('limit')),
      ).thenAnswer((_) async => SuccessBaseResponse(data: response));

      final result = await repo.getCategories(limit: 10);

      expect(result, isA<SuccessBaseResponse<CategoriesResponseEntity>>());
    });

    test('error', () async {
      final failure = Failure(message: 'error');

      when(
        mockDataSource.getCategories(limit: anyNamed('limit')),
      ).thenAnswer((_) async => ErrorBaseResponse(failure: failure));

      final result = await repo.getCategories(limit: 10);

      expect(result, isA<ErrorBaseResponse<CategoriesResponseEntity>>());
    });
  });
}
