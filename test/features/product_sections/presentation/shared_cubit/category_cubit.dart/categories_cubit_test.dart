import 'package:flower/config/base/base_response.dart';
import 'package:flower/config/base/base_state.dart';
import 'package:flower/core/error/error_handler.dart';
import 'package:flower/features/product_sections/data/models/response/categories_response.dart';
import 'package:flower/features/product_sections/domain/entities/category_response_entity.dart';
import 'package:flower/features/product_sections/domain/entities/product_entity.dart';
import 'package:flower/features/product_sections/domain/use_cases/get_categories_use_case.dart';
import 'package:flower/features/product_sections/presentation/shared_cubit/category_cubit/categories_cubit.dart';
import 'package:flower/features/product_sections/presentation/shared_cubit/category_cubit/categories_event.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'categories_cubit_test.mocks.dart';

@GenerateMocks([GetCategoriesUseCase])
void main() {
  late MockGetCategoriesUseCase mockUseCase;
  late CategoriesCubit cubit;

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
    mockUseCase = MockGetCategoriesUseCase();
    cubit = CategoriesCubit(getCategoriesUseCase: mockUseCase);
  });

  tearDown(() => cubit.close());

  test('success flow', () async {
    final data = CategoriesResponseEntity(categories: []);

    when(
      mockUseCase.call(limit: anyNamed('limit')),
    ).thenAnswer((_) async => SuccessBaseResponse(data: data));

    expectLater(
      cubit.stream,
      emitsInOrder([
        const CategoriesState(categoriesState: BaseState(isLoading: true)),
        CategoriesState(categoriesState: BaseState(data: data)),
      ]),
    );

    cubit.onEvent(GetCategoriesEvent());
  });

  test('error flow', () async {
    when(mockUseCase.call(limit: anyNamed('limit'))).thenAnswer(
      (_) async => ErrorBaseResponse(failure: Failure(message: 'error')),
    );

    expectLater(
      cubit.stream,
      emitsThrough(
        predicate<CategoriesState>(
          (s) => s.categoriesState.errorMessage == 'error',
        ),
      ),
    );

    cubit.onEvent(GetCategoriesEvent());
  });

  test('change index', () {
    cubit.onEvent(ChangeSelectedCategoryEvent(2));
    expect(cubit.state.selectedCategoryIndex, 2);
  });
}
