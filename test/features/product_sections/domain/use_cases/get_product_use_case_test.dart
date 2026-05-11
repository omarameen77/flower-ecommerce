import 'package:flower/config/base/base_response.dart';
import 'package:flower/core/error/error_handler.dart';
import 'package:flower/features/product_sections/domain/entities/product_entity.dart';
import 'package:flower/features/product_sections/domain/repositories/products_section_repo.dart';
import 'package:flower/features/product_sections/domain/use_cases/get_products_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_product_use_case_test.mocks.dart';

@GenerateMocks([ProductsSectionRepo])
void main() {
  late MockProductsSectionRepo mockProductsSectionRepo;
  late GetProductsUseCase getProductUseCase;

  late int limit;
  late String sort;

  setUpAll(() {
    limit = 8;
    sort = '-sold';

    provideDummy<BaseResponse<List<ProductEntity>>>(
      SuccessBaseResponse<List<ProductEntity>>(data: const []),
    );
  });

  setUp(() {
    mockProductsSectionRepo = MockProductsSectionRepo();
    getProductUseCase = GetProductsUseCase(
      productsSectionRepo: mockProductsSectionRepo,
    );
  });

  group('get product usecase', () {
    test(
      'should call getProducts on the repository with limit and sort',
      () async {
        const products = <ProductEntity>[
          ProductEntity(id: '1', title: 'Sunny'),
        ];

        when(
          mockProductsSectionRepo.getProducts(limit: limit, sort: sort),
        ).thenAnswer(
          (_) async =>
              SuccessBaseResponse<List<ProductEntity>>(data: products),
        );

        final result = await getProductUseCase.call(limit: limit, sort: sort);

        expect(result, isA<SuccessBaseResponse<List<ProductEntity>>>());
        expect(
          (result as SuccessBaseResponse<List<ProductEntity>>).data,
          products,
        );
        verify(
          mockProductsSectionRepo.getProducts(limit: limit, sort: sort),
        ).called(1);
      },
    );

    test(
      'should propagate ErrorBaseResponse when repository fails',
      () async {
        final failure = ErrorBaseResponse<List<ProductEntity>>(
          failure: Failure(message: 'error'),
        );

        when(
          mockProductsSectionRepo.getProducts(limit: limit, sort: sort),
        ).thenAnswer((_) async => failure);

        final result = await getProductUseCase.call(limit: limit, sort: sort);

        expect(result, isA<ErrorBaseResponse<List<ProductEntity>>>());
        expect(
          (result as ErrorBaseResponse<List<ProductEntity>>).failure.message,
          'error',
        );
      },
    );
  });
}
