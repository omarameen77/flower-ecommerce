/*
UNIT TESTING STEPS
1. ARRANGE
2. ACT
3. ASSERT

EditProfileUseCase — call()

Cases:
1. repository returns success => same SuccessBaseResponse forwarded
2. repository returns error => same ErrorBaseResponse forwarded

Dependency: EditProfileRepository (mock)
*/

import 'package:flower/config/base/base_response.dart';
import 'package:flower/core/error/error_handler.dart';
import 'package:flower/core/network/model/user_models/user_entity.dart';
import 'package:flower/features/edit_profile/domain/repositories/edit_profile_repository.dart';
import 'package:flower/features/edit_profile/domain/usecases/edit_profile_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'edit_profile_use_case_test.mocks.dart';

@GenerateMocks([EditProfileRepository])
void main() {
  late MockEditProfileRepository mockRepository;
  late EditProfileUseCase useCase;

  late UserEntity userEntity;

  setUpAll(() {
    provideDummy<BaseResponse<UserEntity>>(
      SuccessBaseResponse<UserEntity>(
        data: UserEntity(email: 'test@test.com'),
      ),
    );
  });

  setUp(() {
    mockRepository = MockEditProfileRepository();
    useCase = EditProfileUseCase(mockRepository);

    userEntity = UserEntity(
      firstName: 'Nour',
      lastName: 'Mohamed',
      email: 'nour@test.com',
      phone: '+201000000000',
    );
  });

  group('edit profile use case', () {
    test(
      'Return SuccessBaseResponse<UserEntity> when repository succeeds',
      () async {
        when(
          mockRepository.editProfile(
            firstName: anyNamed('firstName'),
            lastName: anyNamed('lastName'),
            email: anyNamed('email'),
            phone: anyNamed('phone'),
          ),
        ).thenAnswer((_) async => SuccessBaseResponse<UserEntity>(data: userEntity));

        final result = await useCase.call(
          firstName: userEntity.firstName!,
          lastName: userEntity.lastName!,
          email: userEntity.email!,
          phone: userEntity.phone!,
        );

        expect(result, isA<SuccessBaseResponse<UserEntity>>());
        expect((result as SuccessBaseResponse<UserEntity>).data.email,
            userEntity.email);
        verify(
          mockRepository.editProfile(
            firstName: userEntity.firstName,
            lastName: userEntity.lastName,
            email: userEntity.email,
            phone: userEntity.phone,
          ),
        ).called(1);
      },
    );

    test(
      'Return ErrorBaseResponse<UserEntity> when repository fails',
      () async {
        final failure = Failure(message: 'not found');
        when(
          mockRepository.editProfile(
            firstName: anyNamed('firstName'),
            lastName: anyNamed('lastName'),
            email: anyNamed('email'),
            phone: anyNamed('phone'),
          ),
        ).thenAnswer(
          (_) async => ErrorBaseResponse<UserEntity>(failure: failure),
        );

        final result = await useCase.call(
          firstName: 'a',
          lastName: 'b',
          email: 'a@b.com',
          phone: '+1',
        );

        expect(result, isA<ErrorBaseResponse<UserEntity>>());
        expect((result as ErrorBaseResponse<UserEntity>).failure.message,
            failure.message);
        verify(
          mockRepository.editProfile(
            firstName: 'a',
            lastName: 'b',
            email: 'a@b.com',
            phone: '+1',
          ),
        ).called(1);
      },
    );
  });
}
