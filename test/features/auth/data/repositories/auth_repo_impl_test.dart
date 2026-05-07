import 'package:flower/config/base/base_response.dart';
import 'package:flower/core/error/error_handler.dart';
import 'package:flower/core/network/model/user.dart';
import 'package:flower/core/network/model/user_entity.dart';
import 'package:flower/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:flower/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:flower/features/auth/domain/usecases/register_params.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_repo_impl_test.mocks.dart';

@GenerateMocks([AuthRemoteDataSourceContract])
void main() {
  // ARRANGE
  late MockAuthRemoteDataSourceContract mockAuthRemoteDataSourceContract;
  late AuthRepoImpl authRepoImpl;

  late String firstName;
  late String lastName;
  late String email;
  late String password;
  late String rePassword;
  late String phone;
  late String gender;

  late String emptyFirstName;
  late String emptyLastName;
  late String emptyEmail;
  late String emptyPassword;
  late String emptyRePassword;
  late String emptyPhone;
  late String emptyGender;

  setUpAll(() {
    firstName = "firstName";
    lastName = "lastName";
    email = "test@example.com";
    password = "Password123!";
    rePassword = "Password123!";
    phone = "0123456789";
    gender = "male";

    emptyFirstName = "";
    emptyLastName = "";
    emptyEmail = "";
    emptyPassword = "";
    emptyRePassword = "";
    emptyPhone = "";
    emptyGender = "";

    // provide dummy data for the base response
    provideDummy<BaseResponse<UserDto>>(
      SuccessBaseResponse<UserDto>(data: UserDto(email: email, id: "1")),
    );
    provideDummy<BaseResponse<UserEntity>>(
      SuccessBaseResponse<UserEntity>(data: UserEntity(email: email)),
    );
  });

  setUp(() {
    mockAuthRemoteDataSourceContract = MockAuthRemoteDataSourceContract();
    authRepoImpl = AuthRepoImpl(
      authRemoteDataSourceContract: mockAuthRemoteDataSourceContract,
    );
  });

  group('auth repo impl', () {
    group('register', () {
      test(
        'Return SuccessBaseResponse<UserEntity> when register is successful',
        () async {
          // ARRANGE
          final userDto = UserDto(
            id: '1',
            firstName: firstName,
            lastName: lastName,
            email: email,
            phone: phone,
            gender: gender,
          );

          final registerParams = RegisterParams(
            firstName: firstName,
            lastName: lastName,
            email: email,
            password: password,
            rePassword: rePassword,
            phone: phone,
            gender: gender,
          );

          when(mockAuthRemoteDataSourceContract.register(registerParams))
              .thenAnswer((_) async => SuccessBaseResponse<UserDto>(data: userDto));

          // ACT
          final result = await authRepoImpl.register(registerParams);

          // ASSERT
          expect(result, isA<SuccessBaseResponse<UserEntity>>());
          final successResult = result as SuccessBaseResponse<UserEntity>;
          expect(successResult.data.email, email);
          verify(mockAuthRemoteDataSourceContract.register(registerParams)).called(1);
        },
      );

      test("Return ErrorBaseResponse<UserEntity> when register fails", () async {
        // ARRANGE
        final tFailure = Failure(message: 'error');
        final tParams = RegisterParams(
          firstName: firstName,
          lastName: lastName,
          email: email,
          password: password,
          rePassword: rePassword,
          phone: phone,
          gender: gender,
        );

        when(mockAuthRemoteDataSourceContract.register(tParams))
            .thenAnswer((_) async => ErrorBaseResponse<UserDto>(failure: tFailure));

        // ACT
        final result = await authRepoImpl.register(tParams);

        // ASSERT
        expect(result, isA<ErrorBaseResponse<UserEntity>>());
        expect((result as ErrorBaseResponse<UserEntity>).failure, tFailure);
      });

      test("Return ErrorBaseResponse<UserEntity> when fields are empty", () async {
        // ARRANGE
        final failure = Failure(message: 'fields are required');
        final registerParams = RegisterParams(
          firstName: emptyFirstName,
          lastName: emptyLastName,
          email: emptyEmail,
          password: emptyPassword,
          rePassword: emptyRePassword,
          phone: emptyPhone,
          gender: emptyGender,
        );

        when(mockAuthRemoteDataSourceContract.register(registerParams))
            .thenAnswer((_) async => ErrorBaseResponse<UserDto>(failure: failure));

        // ACT
        final result = await authRepoImpl.register(registerParams);

        // ASSERT
        expect(result, isA<ErrorBaseResponse<UserEntity>>());
        expect((result as ErrorBaseResponse<UserEntity>).failure, failure);
      });
    });
  });
}
