import 'package:flower/config/base/base_response.dart';
import 'package:flower/features/product_sections/api/api_client/products_sections_api_client.dart';
import 'package:flower/features/product_sections/api/datasource/products_sections_data_source_impl.dart';
import 'package:flower/features/product_sections/data/models/dtos/product_dto.dart';
import 'package:flower/features/product_sections/data/models/response/product_details_response.dart';
import 'package:flower/features/product_sections/data/models/response/products_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'products_sections_data_source_impl_test.mocks.dart';

@GenerateMocks([ProductsSectionsApiClient])
void main() {
  late MockProductsSectionsApiClient mockApiClient;
  late ProductsSectionsDataSourceImpl dataSource;

  late int limit;
  late String sort;

  setUpAll(() {
    limit = 8;
    sort = '-sold';

    provideDummy<ProductsResponse>(ProductsResponse(products: const []));
    provideDummy<ProductDetailsResponse>(const ProductDetailsResponse());
  });

  setUp(() {
    mockApiClient = MockProductsSectionsApiClient();
    dataSource = ProductsSectionsDataSourceImpl(
      productsSectionsApiClient: mockApiClient,
    );
  });

  group('products sections data source impl', () {
    group('getProducts', () {
      test(
        'Return SuccessBaseResponse<List<ProductDto>> when api call is successful',
        () async {
          final dtos = [
            ProductDto(id: '1', title: 'Sunny'),
            ProductDto(id: '2', title: 'Red roses'),
          ];
          final response = ProductsResponse(products: dtos);

          when(
            mockApiClient.getProducts(
              limit: anyNamed('limit'),
              sort: anyNamed('sort'),
            ),
          ).thenAnswer((_) async => response);

          final result = await dataSource.getProducts(
            limit: limit,
            sort: sort,
          );

          expect(result, isA<SuccessBaseResponse<List<ProductDto>>>());
          final data = (result as SuccessBaseResponse<List<ProductDto>>).data;
          expect(data, hasLength(2));
          verify(mockApiClient.getProducts(limit: limit, sort: sort)).called(1);
        },
      );

      test(
        'Return ErrorBaseResponse<List<ProductDto>> when api call throws',
        () async {
          when(
            mockApiClient.getProducts(
              limit: anyNamed('limit'),
              sort: anyNamed('sort'),
            ),
          ).thenThrow(Exception('network error'));

          final result = await dataSource.getProducts(
            limit: limit,
            sort: sort,
          );

          expect(result, isA<ErrorBaseResponse<List<ProductDto>>>());
          expect(
            (result as ErrorBaseResponse<List<ProductDto>>).failure.message,
            isNotNull,
          );
        },
      );
    });

    group('getProductById', () {
      const productId = '1';

      test(
        'Return SuccessBaseResponse<ProductDto> when api returns a product',
        () async {
          final dto = ProductDto(id: productId, title: 'Sunny');
          final response = ProductDetailsResponse(product: dto);

          when(
            mockApiClient.getProductById(productId),
          ).thenAnswer((_) async => response);

          final result = await dataSource.getProductById(productId);

          expect(result, isA<SuccessBaseResponse<ProductDto>>());
          final data = (result as SuccessBaseResponse<ProductDto>).data;
          expect(data.id, productId);
          verify(mockApiClient.getProductById(productId)).called(1);
        },
      );

      test(
        'Return ErrorBaseResponse<ProductDto> when api returns null product',
        () async {
          when(
            mockApiClient.getProductById(productId),
          ).thenAnswer((_) async => const ProductDetailsResponse());

          final result = await dataSource.getProductById(productId);

          expect(result, isA<ErrorBaseResponse<ProductDto>>());
          expect(
            (result as ErrorBaseResponse<ProductDto>).failure.message,
            isNotNull,
          );
        },
      );

      test(
        'Return ErrorBaseResponse<ProductDto> when api call throws',
        () async {
          when(
            mockApiClient.getProductById(productId),
          ).thenThrow(Exception('network error'));

          final result = await dataSource.getProductById(productId);

          expect(result, isA<ErrorBaseResponse<ProductDto>>());
          expect(
            (result as ErrorBaseResponse<ProductDto>).failure.message,
            isNotNull,
          );
        },
      );
    });
  });
}
