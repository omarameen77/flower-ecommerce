import 'package:flower/config/base/base_response.dart';
import 'package:flower/core/error/error_handler.dart';
import 'package:flower/core/network/safe_api_caller.dart';
import 'package:flower/features/product_sections/api/api_client/products_sections_api_client.dart';
import 'package:flower/features/product_sections/api/datasource/categories_data_source_impl.dart';
import 'package:flower/features/product_sections/data/models/response/categories_response.dart';
import 'package:flower/features/product_sections/domain/entities/category_response_entity.dart';
import 'package:flower/features/product_sections/domain/entities/product_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'categories_data_source_impl_test.mocks.dart';

@GenerateMocks([ProductsSectionsApiClient, SafeApiCaller])
void main() {
  late MockProductsSectionsApiClient mockApiClient;
  late MockSafeApiCaller mockCaller;
  late CategoriesDataSourceImpl dataSource;

  setUpAll(() {
    provideDummy<BaseResponse<CategoriesResponse>>(
      SuccessBaseResponse(data: CategoriesResponse(categories: [])),
    );

    provideDummy<BaseResponse<CategoriesResponseEntity>>(
      SuccessBaseResponse(data: CategoriesResponseEntity(categories: [])),
    );

    provideDummy<BaseResponse<List<ProductEntity>>>(
      SuccessBaseResponse(data: []),
    );
  });

  setUp(() {
    mockApiClient = MockProductsSectionsApiClient();
    mockCaller = MockSafeApiCaller();

    dataSource = CategoriesDataSourceImpl(
      apiClient: mockApiClient,
      call: mockCaller,
    );
  });

  group('Categories DataSource', () {
    test('success case', () async {
      final response = CategoriesResponse(categories: []);

      when(
        mockApiClient.getCategories(limit: anyNamed('limit')),
      ).thenAnswer((_) async => response);

      when(mockCaller.safeCall<CategoriesResponse>(any)).thenAnswer((
        invocation,
      ) async {
        final fn = invocation.positionalArguments[0] as Function;
        final result = await fn();
        return SuccessBaseResponse(data: result);
      });

      final result = await dataSource.getCategories(limit: 10);

      expect(result, isA<SuccessBaseResponse<CategoriesResponse>>());
    });

    test('error case', () async {
      when(mockCaller.safeCall<CategoriesResponse>(any)).thenAnswer((_) async {
        return ErrorBaseResponse(failure: Failure(message: 'error'));
      });

      final result = await dataSource.getCategories(limit: 10);

      expect(result, isA<ErrorBaseResponse<CategoriesResponse>>());
    });
  });
}
