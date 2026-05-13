import 'package:flower/config/base/base_response.dart';
import 'package:flower/core/error/error_handler.dart';
import 'package:flower/features/product_sections/domain/entities/product_entity.dart';
import 'package:flower/features/product_sections/domain/repositories/products_section_repo.dart';
import 'package:flower/features/product_sections/domain/use_cases/get_product_by_id_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_product_by_id_use_case_test.mocks.dart';

@GenerateMocks([ProductsSectionRepo])
void main() {
  late MockProductsSectionRepo mockProductsSectionRepo;
  late GetProductByIdUseCase getProductByIdUseCase;

  late String productId;

  setUpAll(() {
    productId = '1';

    provideDummy<BaseResponse<ProductEntity>>(
      SuccessBaseResponse<ProductEntity>(
        data: const ProductEntity(id: '1', title: 'Sunny'),
      ),
    );
  });

  setUp(() {
    mockProductsSectionRepo = MockProductsSectionRepo();
    getProductByIdUseCase = GetProductByIdUseCase(
      productsSectionRepo: mockProductsSectionRepo,
    );
  });

  group('get product by id usecase', () {
    test(
      'should call getProductById on the repository with the id',
      () async {
        const product = ProductEntity(id: '1', title: 'Sunny');

        when(
          mockProductsSectionRepo.getProductById(productId),
        ).thenAnswer(
          (_) async => SuccessBaseResponse<ProductEntity>(data: product),
        );

        final result = await getProductByIdUseCase.call(productId);

        expect(result, isA<SuccessBaseResponse<ProductEntity>>());
        expect(
          (result as SuccessBaseResponse<ProductEntity>).data,
          product,
        );
        verify(mockProductsSectionRepo.getProductById(productId)).called(1);
      },
    );

    test(
      'should propagate ErrorBaseResponse when repository fails',
      () async {
        final failure = ErrorBaseResponse<ProductEntity>(
          failure: Failure(message: 'not found'),
        );

        when(
          mockProductsSectionRepo.getProductById(productId),
        ).thenAnswer((_) async => failure);

        final result = await getProductByIdUseCase.call(productId);

        expect(result, isA<ErrorBaseResponse<ProductEntity>>());
        expect(
          (result as ErrorBaseResponse<ProductEntity>).failure.message,
          'not found',
        );
      },
    );
  });
}
