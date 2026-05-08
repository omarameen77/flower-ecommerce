import 'package:flower/config/base/base_response.dart';
import 'package:flower/core/network/model/user_entity.dart';
import 'package:flower/features/auth/domain/repositories/auth_repo.dart';
import 'package:flower/features/auth/domain/use_cases/register_params.dart';
import 'package:flower/features/auth/domain/use_cases/register_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'register_use_case_test.mocks.dart';

@GenerateMocks([AuthRepo])
void main() {
  // ARRANGE
  late MockAuthRepo mockAuthRepo;
  late RegisterUseCase registerUseCase;

  late String firstName;
  late String lastName;
  late String email;
  late String password;
  late String rePassword;
  late String phone;
  late String gender;

  setUpAll(() {
    firstName = "firstName";
    lastName = "lastName";
    email = "test@example.com";
    password = "Password123!";
    rePassword = "Password123!";
    phone = "0123456789";
    gender = "male";

    provideDummy<BaseResponse<UserEntity>>(
      SuccessBaseResponse<UserEntity>(data: UserEntity(email: email)),
    );
  });

  setUp(() {
    mockAuthRepo = MockAuthRepo();
    registerUseCase = RegisterUseCase(
      registerRepoContract: mockAuthRepo,
    );
  });

  group('register usecase', () {
    test(
      'should call register on the repository',
      () async {
        // ARRANGE
        final userEntity = UserEntity(email: email);
        final params = RegisterParams(
          firstName: firstName,
          lastName: lastName,
          email: email,
          password: password,
          rePassword: rePassword,
          phone: phone,
          gender: gender,
        );

        when(mockAuthRepo.register(params))
            .thenAnswer((_) async => SuccessBaseResponse<UserEntity>(data: userEntity));

        // ACT
        final result = await registerUseCase.call(params);

        // ASSERT
        expect(result, isA<SuccessBaseResponse<UserEntity>>());
        expect((result as SuccessBaseResponse<UserEntity>).data, userEntity);
        verify(mockAuthRepo.register(params)).called(1);
      },
    );
  });
}