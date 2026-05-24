import 'package:flower/config/base/base_response.dart';
import 'package:flower/core/error/error_handler.dart';
import 'package:flower/core/network/model/user_entity.dart';
import 'package:flower/core/profile/domain/repositories/profile_repository.dart';
import 'package:flower/core/profile/domain/usecases/get_profile_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_profile_use_case_test.mocks.dart';

@GenerateMocks([ProfileRepository])
void main() {
  late GetProfileUseCase getProfileUseCase;
  late MockProfileRepository mockProfileRepository;

  setUpAll(() {
    provideDummy<BaseResponse<UserEntity>>(
      SuccessBaseResponse<UserEntity>(
        data: UserEntity(email: "test@example.com"),
      ),
    );
  });

  setUp(() {
    mockProfileRepository = MockProfileRepository();
    getProfileUseCase = GetProfileUseCase(mockProfileRepository);
  });

  final tUserEntity = UserEntity(
    id: "1",
    email: "test@example.com",
    firstName: "Test",
    lastName: "User",
  );

  test(
    'should return SuccessBaseResponse when repository call is successful',
    () async {
      when(mockProfileRepository.getProfile()).thenAnswer(
        (_) async => SuccessBaseResponse<UserEntity>(data: tUserEntity),
      );

      final result = await getProfileUseCase.call();

      expect(result, isA<SuccessBaseResponse<UserEntity>>());
      final successResult = result as SuccessBaseResponse<UserEntity>;
      expect(successResult.data, tUserEntity);
      verify(mockProfileRepository.getProfile()).called(1);
      verifyNoMoreInteractions(mockProfileRepository);
    },
  );

  test('should return ErrorBaseResponse when repository call fails', () async {
    final tFailure = Failure(message: 'Profile fetch failed');
    when(
      mockProfileRepository.getProfile(),
    ).thenAnswer((_) async => ErrorBaseResponse<UserEntity>(failure: tFailure));

    final result = await getProfileUseCase.call();

    expect(result, isA<ErrorBaseResponse<UserEntity>>());
    final errorResult = result as ErrorBaseResponse<UserEntity>;
    expect(errorResult.failure, tFailure);
    verify(mockProfileRepository.getProfile()).called(1);
    verifyNoMoreInteractions(mockProfileRepository);
  });
}
