import 'package:flower/config/base/base_response.dart';
import 'package:flower/core/error/error_handler.dart';
import 'package:flower/features/product_sections/data/models/response/categories_response.dart';
import 'package:flower/features/product_sections/domain/entities/category_response_entity.dart';
import 'package:flower/features/product_sections/domain/entities/product_entity.dart';
import 'package:flower/features/product_sections/domain/repositories/categories_repo.dart';
import 'package:flower/features/product_sections/domain/use_cases/get_categories_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_categories_use_case_test.mocks.dart';

@GenerateMocks([CategoryRepoContract])
void main() {
  late MockCategoryRepoContract mockRepo;
  late GetCategoriesUseCase useCase;

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
    mockRepo = MockCategoryRepoContract();
    useCase = GetCategoriesUseCase(repo: mockRepo);
  });

  test('success', () async {
    final data = CategoriesResponseEntity(categories: []);

    when(
      mockRepo.getCategories(limit: anyNamed('limit')),
    ).thenAnswer((_) async => SuccessBaseResponse(data: data));

    final result = await useCase.call(limit: 10);

    expect(result, isA<SuccessBaseResponse<CategoriesResponseEntity>>());
  });

  test('error', () async {
    when(mockRepo.getCategories(limit: anyNamed('limit'))).thenAnswer(
      (_) async => ErrorBaseResponse(failure: Failure(message: 'error')),
    );

    final result = await useCase.call(limit: 10);

    expect(result, isA<ErrorBaseResponse<CategoriesResponseEntity>>());
  });
}
