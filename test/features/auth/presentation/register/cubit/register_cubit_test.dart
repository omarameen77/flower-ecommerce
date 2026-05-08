/*

UNIT TESTING STEPS IN THE MAIN FUNCTION
1. ARRANGE
    1. Create and get all dependencies and variables needed for the test
    

2. ACT
3. ASSERT




 */

/*

Register Cubit


UseCases: 
1. register success  => emit [loading, success]
2. register error    => emit [loading, error]
3. change gender     => emit [selectedGender]

Dependencies:
1. RegisterUsecase


*/

import 'package:flower/config/base/base_response.dart';
import 'package:flower/config/base/base_state.dart';
import 'package:flower/core/error/error_handler.dart';
import 'package:flower/core/network/model/user_entity.dart';
import 'package:flower/features/auth/domain/use_cases/register_params.dart';
import 'package:flower/features/auth/domain/use_cases/register_use_case.dart';
import 'package:flower/features/auth/presentation/register/cubit/register_cubit.dart';
import 'package:flower/features/auth/presentation/register/cubit/register_event.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'register_cubit_test.mocks.dart';

@GenerateMocks([RegisterUseCase])
void main() {
  // ARRANGE
  late MockRegisterUseCase mockRegisterUseCase;
  late RegisterCubit registerCubit;

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
    mockRegisterUseCase = MockRegisterUseCase();
    registerCubit = RegisterCubit(mockRegisterUseCase);
  });

  tearDown(() {
    registerCubit.close();
  });

  group('register cubit', () {
    group('register', () {
      // first usecase
      test(
        'should emit [loading, success] when registration is successful',
        () async {
          // ARRANGE
          final userEntity = UserEntity(email: email);
          final event = Register(
            firstName: firstName,
            lastName: lastName,
            email: email,
            password: password,
            rePassword: rePassword,
            phone: phone,
            gender: gender,
          );
          final params = RegisterParams(
            firstName: firstName,
            lastName: lastName,
            email: email,
            password: password,
            rePassword: rePassword,
            phone: phone,
            gender: gender,
          );

          when(mockRegisterUseCase.call(params)).thenAnswer(
            (_) async => SuccessBaseResponse<UserEntity>(data: userEntity),
          );

          // ASSERT later
          final expected = [
            RegisterState(
              registerState: const BaseState(isLoading: true),
            ),
            RegisterState(
              registerState: BaseState(data: userEntity, isLoading: false),
            ),
          ];
          expectLater(registerCubit.stream, emitsInOrder(expected));

          // ACT
          registerCubit.doEvent(event);
        },
      );

      test(
        'should emit [loading, error] when registration fails',
        () async {
          // ARRANGE
          final failure = Failure(message: 'error');
          final event = Register(
            firstName: firstName,
            lastName: lastName,
            email: email,
            password: password,
            rePassword: rePassword,
            phone: phone,
            gender: gender,
          );
          final params = RegisterParams(
            firstName: firstName,
            lastName: lastName,
            email: email,
            password: password,
            rePassword: rePassword,
            phone: phone,
            gender: gender,
          );

          when(mockRegisterUseCase.call(params)).thenAnswer(
            (_) async => ErrorBaseResponse<UserEntity>(failure: failure),
          );

          // ASSERT later
          final expected = [
            RegisterState(
              registerState: const BaseState(isLoading: true),
            ),
            RegisterState(
              registerState: const BaseState(isLoading: false, errorMessage: 'error'),
            ),
          ];
          expectLater(registerCubit.stream, emitsInOrder(expected));

          // ACT
          registerCubit.doEvent(event);
        },
      );
    });

    group('change gender', () {
      test('should emit state with new selected gender', () {
        // ARRANGE
        const newGender = 'female';
        final event = ChangeGender(newGender);

        // ASSERT later
        final expected = [
          RegisterState(
            registerState: const BaseState(),
            selectedGender: newGender,
          ),
        ];
        expectLater(registerCubit.stream, emitsInOrder(expected));

        // ACT
        registerCubit.doEvent(event);
      });
    });
  });
}
