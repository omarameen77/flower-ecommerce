/*
UNIT TESTING STEPS
1. ARRANGE
2. ACT
3. ASSERT

GetProfileUseCase — call()

Cases:
1. repository returns success => same SuccessBaseResponse forwarded
2. repository returns error => same ErrorBaseResponse forwarded

Dependency: ProfileRepository (mock)
*/

import 'package:flower/config/base/base_response.dart';
import 'package:flower/core/error/error_handler.dart';
import 'package:flower/core/network/model/user_models/user_entity.dart';
import 'package:flower/core/profile/domain/repositories/profile_repository.dart';
import 'package:flower/core/profile/domain/usecases/get_profile_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_profile_use_case_test.mocks.dart';

@GenerateMocks([ProfileRepository])
void main() {
  late MockProfileRepository mockProfileRepository;
  late GetProfileUseCase useCase;

  late UserEntity userEntity;

  setUpAll(() {
    provideDummy<BaseResponse<UserEntity>>(
      SuccessBaseResponse<UserEntity>(
        data: UserEntity(email: 'test@test.com'),
      ),
    );
  });

  setUp(() {
    mockProfileRepository = MockProfileRepository();
    useCase = GetProfileUseCase(mockProfileRepository);

    userEntity = UserEntity(
      firstName: 'Nour',
      lastName: 'Mohamed',
      email: 'nour@test.com',
    );
  });

  group('get profile use case', () {
    test(
      'Return SuccessBaseResponse<UserEntity> when repository succeeds',
      () async {
        // ARRANGE
        when(mockProfileRepository.getProfile()).thenAnswer(
          (_) async => SuccessBaseResponse<UserEntity>(data: userEntity),
        );

        // ACT
        final result = await useCase.call();

        // ASSERT
        expect(result, isA<SuccessBaseResponse<UserEntity>>());
        expect((result as SuccessBaseResponse<UserEntity>).data.email,
            userEntity.email);
        verify(mockProfileRepository.getProfile()).called(1);
      },
    );

    test(
      'Return ErrorBaseResponse<UserEntity> when repository fails',
      () async {
        // ARRANGE
        final failure = Failure(message: 'not found');
        when(mockProfileRepository.getProfile()).thenAnswer(
          (_) async => ErrorBaseResponse<UserEntity>(failure: failure),
        );

        // ACT
        final result = await useCase.call();

        // ASSERT
        expect(result, isA<ErrorBaseResponse<UserEntity>>());
        expect((result as ErrorBaseResponse<UserEntity>).failure.message,
            failure.message);
        verify(mockProfileRepository.getProfile()).called(1);
      },
    );
  });
}
