import 'package:flower/config/base/base_response.dart';
import 'package:flower/config/base/base_state.dart';
import 'package:flower/core/error/error_handler.dart';
import 'package:flower/features/product_sections/domain/entities/product_entity.dart';
import 'package:flower/features/product_sections/domain/use_cases/get_product_by_id_use_case.dart';
import 'package:flower/features/product_sections/presentation/product_details/cubit/product_details_cubit.dart';
import 'package:flower/features/product_sections/presentation/product_details/cubit/product_details_event.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'product_details_cubit_test.mocks.dart';

@GenerateMocks([GetProductByIdUseCase])
void main() {
  late MockGetProductByIdUseCase mockGetProductByIdUseCase;
  late ProductDetailsCubit productDetailsCubit;

  late String productId;
  late ProductEntity product;

  setUpAll(() {
    productId = '1';
    product = const ProductEntity(id: '1', title: 'Sunny', price: 600);

    provideDummy<BaseResponse<ProductEntity>>(
      SuccessBaseResponse<ProductEntity>(
        data: const ProductEntity(id: '1', title: 'Sunny'),
      ),
    );
  });

  setUp(() {
    mockGetProductByIdUseCase = MockGetProductByIdUseCase();
    productDetailsCubit = ProductDetailsCubit(
      getProductByIdUseCase: mockGetProductByIdUseCase,
    );
  });

  tearDown(() {
    productDetailsCubit.close();
  });

  group('product details cubit', () {
    group('fetch product by id', () {
      test(
        'should emit [loading, success] when fetch is successful',
        () async {
          when(mockGetProductByIdUseCase.call(productId)).thenAnswer(
            (_) async => SuccessBaseResponse<ProductEntity>(data: product),
          );

          final expected = [
            const ProductDetailsState(
              productBaseState: BaseState<ProductEntity>(isLoading: true),
            ),
            ProductDetailsState(
              productBaseState: BaseState<ProductEntity>(data: product),
            ),
          ];
          expectLater(productDetailsCubit.stream, emitsInOrder(expected));

          productDetailsCubit.doEvent(GetProductDetailsEvent(productId));
        },
      );

      test(
        'should emit [loading, error] when fetch fails',
        () async {
          final failure = Failure(message: 'not found');
          when(mockGetProductByIdUseCase.call(productId)).thenAnswer(
            (_) async =>
                ErrorBaseResponse<ProductEntity>(failure: failure),
          );

          final expected = [
            const ProductDetailsState(
              productBaseState: BaseState<ProductEntity>(isLoading: true),
            ),
            const ProductDetailsState(
              productBaseState: BaseState<ProductEntity>(
                errorMessage: 'not found',
              ),
            ),
          ];
          expectLater(productDetailsCubit.stream, emitsInOrder(expected));

          productDetailsCubit.doEvent(GetProductDetailsEvent(productId));
        },
      );
    });
  });
}
