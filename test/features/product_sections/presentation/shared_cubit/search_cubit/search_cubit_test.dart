import 'package:flower/config/base/base_response.dart';
import 'package:flower/config/base/base_state.dart';
import 'package:flower/core/error/error_handler.dart';
import 'package:flower/features/product_sections/domain/entities/product_entity.dart';
import 'package:flower/features/product_sections/domain/use_cases/get_products_use_case.dart';
import 'package:flower/features/product_sections/presentation/shared_cubit/search_cubit/search_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'search_cubit_test.mocks.dart';

@GenerateMocks([GetProductsUseCase])
void main() {
  late MockGetProductsUseCase mockUseCase;
  late SearchCubit cubit;

  setUpAll(() {
    provideDummy<BaseResponse<List<ProductEntity>>>(
      SuccessBaseResponse(data: []),
    );
  });

  setUp(() {
    mockUseCase = MockGetProductsUseCase();
    cubit = SearchCubit(mockUseCase);
  });

  tearDown(() => cubit.close());

  group('SearchCubit', () {
    test('success search', () async {
      final products = [const ProductEntity(id: '1', title: 'test')];

      when(
        mockUseCase.call(
          keyword: anyNamed('keyword'),
          limit: anyNamed('limit'),
        ),
      ).thenAnswer((_) async => SuccessBaseResponse(data: products));

      expectLater(
        cubit.stream,
        emitsInOrder([
          const BaseState<List<ProductEntity>>(isLoading: true, data: []),
          BaseState<List<ProductEntity>>(data: products),
        ]),
      );

      await cubit.search('flower');
    });

    test('error search', () async {
      when(
        mockUseCase.call(
          keyword: anyNamed('keyword'),
          limit: anyNamed('limit'),
        ),
      ).thenAnswer(
        (_) async => ErrorBaseResponse(failure: Failure(message: 'error')),
      );

      await cubit.search('flower');

      expect(cubit.state.productsState.errorMessage, 'error');
    });

    test('clear results', () {
      cubit.clear();
      expect(cubit.state.productsState.data, []);
    });
  });
}
