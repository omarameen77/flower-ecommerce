import 'package:flower/config/base/base_response.dart';
import 'package:flower/core/network/model/user.dart';
import 'package:flower/features/auth/api/api_client/auth_api_client.dart';
import 'package:flower/features/auth/api/datasources/auth_remote_data_source_impl.dart';
import 'package:flower/features/auth/data/models/response/register_response.dart';
import 'package:flower/features/auth/domain/usecases/register_params.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([AuthApiClient])
void main() {
  // ARRANGE
  late MockAuthApiClient mockAuthApiClient;
  late AuthRemoteDataSourceImpl authRemoteDataSourceImpl;

  late String firstName;
  late String lastName;
  late String email;
  late String password;
  late String rePassword;
  late String phone;
  late String gender;

  setUpAll(() {
    mockAuthApiClient = MockAuthApiClient();
    authRemoteDataSourceImpl = AuthRemoteDataSourceImpl(
      authApiClient: mockAuthApiClient,
    );

    firstName = "firstName";
    lastName = "lastName";
    email = "test@example.com";
    password = "Password123!";
    rePassword = "Password123!";
    phone = "0123456789";
    gender = "male";

    provideDummy<RegisterResponseDto>(
      RegisterResponseDto(user: UserDto(email: email, id: "1")),
    );
  });

  group('auth remote data source impl', () {
    group('register', () {
      test(
        'Return SuccessBaseResponse<UserDto> when register is successful',
        () async {
          // ARRANGE
          final tUserDto = UserDto(
            id: '1',
            firstName: firstName,
            lastName: lastName,
            email: email,
            phone: phone,
            gender: gender,
          );
          final tResponse = RegisterResponseDto(user: tUserDto, message: 'success');

          final tParams = RegisterParams(
            firstName: firstName,
            lastName: lastName,
            email: email,
            password: password,
            rePassword: rePassword,
            phone: phone,
            gender: gender,
          );

          when(mockAuthApiClient.register(any)).thenAnswer((_) async => tResponse);

          // ACT
          final result = await authRemoteDataSourceImpl.register(tParams);

          // ASSERT
          expect(result, isA<SuccessBaseResponse<UserDto>>());
          final successResult = result as SuccessBaseResponse<UserDto>;
          expect(successResult.data.email, email);
          verify(mockAuthApiClient.register(any)).called(1);
        },
      );

      test("Return ErrorBaseResponse<UserDto> when register fails", () async {
        // ARRANGE
        final tParams = RegisterParams(
          firstName: firstName,
          lastName: lastName,
          email: email,
          password: password,
          rePassword: rePassword,
          phone: phone,
          gender: gender,
        );

        when(mockAuthApiClient.register(any)).thenThrow(Exception('error'));

        // ACT
        final result = await authRemoteDataSourceImpl.register(tParams);

        // ASSERT
        expect(result, isA<ErrorBaseResponse<UserDto>>());
      });
    });
  });
}