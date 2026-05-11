import 'package:flower/config/base/base_response.dart';
import 'package:flower/config/base/base_state.dart';
import 'package:flower/core/error/error_handler.dart';
import 'package:flower/features/product_sections/domain/entities/product_entity.dart';
import 'package:flower/features/product_sections/domain/use_cases/get_product_use_case.dart';
import 'package:flower/features/product_sections/presentation/shared_cubit/product_cubit/product_cubit.dart';
import 'package:flower/features/product_sections/presentation/shared_cubit/product_cubit/product_event.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'product_cubit_test.mocks.dart';

@GenerateMocks([GetProductUseCase])
void main() {
  late MockGetProductUseCase mockGetProductUseCase;
  late ProductCubit productCubit;

  late List<ProductEntity> products;

  setUpAll(() {
    products = const [
      ProductEntity(id: '1', title: 'Sunny', price: 600),
      ProductEntity(id: '2', title: 'Red roses', price: 600),
    ];

    provideDummy<BaseResponse<List<ProductEntity>>>(
      SuccessBaseResponse<List<ProductEntity>>(data: const []),
    );
  });

  setUp(() {
    mockGetProductUseCase = MockGetProductUseCase();
    productCubit = ProductCubit(getProductUseCase: mockGetProductUseCase);
  });

  tearDown(() {
    productCubit.close();
  });

  group('product cubit', () {
    group('fetch products', () {
      test(
        'should emit [loading, success] when fetch is successful',
        () async {
          when(
            mockGetProductUseCase.call(
              limit: anyNamed('limit'),
              sort: anyNamed('sort'),
            ),
          ).thenAnswer(
            (_) async => SuccessBaseResponse<List<ProductEntity>>(
              data: products,
            ),
          );

          final expected = [
            const ProductState(
              productBaseState: BaseState<List<ProductEntity>>(
                isLoading: true,
                data: [],
              ),
            ),
            ProductState(
              productBaseState: BaseState<List<ProductEntity>>(data: products),
            ),
          ];
          expectLater(productCubit.stream, emitsInOrder(expected));

          productCubit.doEvent(const GetProductEvent());
        },
      );

      test(
        'should emit [loading, error] when fetch fails',
        () async {
          final failure = Failure(message: 'error');
          when(
            mockGetProductUseCase.call(
              limit: anyNamed('limit'),
              sort: anyNamed('sort'),
            ),
          ).thenAnswer(
            (_) async =>
                ErrorBaseResponse<List<ProductEntity>>(failure: failure),
          );

          final expected = [
            const ProductState(
              productBaseState: BaseState<List<ProductEntity>>(
                isLoading: true,
                data: [],
              ),
            ),
            const ProductState(
              productBaseState: BaseState<List<ProductEntity>>(
                errorMessage: 'error',
                data: [],
              ),
            ),
          ];
          expectLater(productCubit.stream, emitsInOrder(expected));

          productCubit.doEvent(const GetProductEvent());
        },
      );
    });

    group('setSort', () {
      test(
        'should call use case with the chosen sort value',
        () async {
          when(
            mockGetProductUseCase.call(
              limit: anyNamed('limit'),
              sort: anyNamed('sort'),
            ),
          ).thenAnswer(
            (_) async =>
                SuccessBaseResponse<List<ProductEntity>>(data: const []),
          );

          productCubit.setSort('-sold');
          productCubit.doEvent(const GetProductEvent());
          await Future<void>.delayed(Duration.zero);

          verify(
            mockGetProductUseCase.call(limit: 8, sort: '-sold'),
          ).called(1);
        },
      );
    });
  });
}
