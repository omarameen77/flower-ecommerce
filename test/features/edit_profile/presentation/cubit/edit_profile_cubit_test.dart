/*
UNIT TESTING STEPS
1. ARRANGE
2. ACT
3. ASSERT

EditProfileCubit — doEvent(EditProfileEvent)

Cases:
1. EditProfileFirstNameChanged — updates firstName
2. EditProfileSubmitted — no changes => use case not called
3. EditProfileSubmitted — has changes => loading then success
4. EditProfileSubmitted — has changes => loading then error from use case

Dependency: EditProfileUseCase (mock)
*/

import 'package:flower/config/base/base_response.dart';
import 'package:flower/config/base/base_state.dart';
import 'package:flower/core/error/error_handler.dart';
import 'package:flower/core/network/model/user_models/user_entity.dart';
import 'package:flower/features/edit_profile/domain/usecases/edit_profile_use_case.dart';
import 'package:flower/features/edit_profile/presentation/cubit/edit_profile_cubit.dart';
import 'package:flower/features/edit_profile/presentation/cubit/edit_profile_event.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'edit_profile_cubit_test.mocks.dart';

@GenerateMocks([EditProfileUseCase])
void main() {
  late MockEditProfileUseCase mockUseCase;
  late EditProfileCubit cubit;

  late UserEntity initialUser;
  late UserEntity updatedUser;

  setUpAll(() {
    provideDummy<BaseResponse<UserEntity>>(
      SuccessBaseResponse<UserEntity>(
        data: UserEntity(email: 'test@test.com'),
      ),
    );
  });

  setUp(() {
    mockUseCase = MockEditProfileUseCase();
    initialUser = UserEntity(
      firstName: 'Nour',
      lastName: 'Mohamed',
      email: 'nour@test.com',
      phone: '+201000000000',
    );
    updatedUser = UserEntity(
      firstName: 'NourUpdated',
      lastName: 'Mohamed',
      email: 'nour@test.com',
      phone: '+201000000000',
    );
    cubit = EditProfileCubit(mockUseCase, initialUser);
  });

  tearDown(() {
    cubit.close();
  });

  group('edit profile cubit', () {
    group('EditProfileFirstNameChanged', () {
      test('emits state with updated firstName', () async {
        final expected = [
          EditProfileState(
            firstName: 'X',
            lastName: initialUser.lastName ?? '',
            email: initialUser.email ?? '',
            phone: initialUser.phone ?? '',
          ),
        ];

        final done = expectLater(cubit.stream, emitsInOrder(expected));

        cubit.doEvent(const EditProfileFirstNameChanged('X'));

        await done;
        verifyNever(
          mockUseCase.call(
            firstName: anyNamed('firstName'),
            lastName: anyNamed('lastName'),
            email: anyNamed('email'),
            phone: anyNamed('phone'),
          ),
        );
      });
    });

    group('EditProfileSubmitted', () {
      test('does not call use case when there are no changes', () async {
        cubit.doEvent(const EditProfileSubmitted());

        await Future<void>.delayed(Duration.zero);

        verifyNever(
          mockUseCase.call(
            firstName: anyNamed('firstName'),
            lastName: anyNamed('lastName'),
            email: anyNamed('email'),
            phone: anyNamed('phone'),
          ),
        );
      });

      test('emits loading then success when use case succeeds', () async {
        when(
          mockUseCase.call(
            firstName: anyNamed('firstName'),
            lastName: anyNamed('lastName'),
            email: anyNamed('email'),
            phone: anyNamed('phone'),
          ),
        ).thenAnswer(
          (_) async => SuccessBaseResponse<UserEntity>(data: updatedUser),
        );

        final expected = [
          EditProfileState(
            firstName: 'NourUpdated',
            lastName: initialUser.lastName ?? '',
            email: initialUser.email ?? '',
            phone: initialUser.phone ?? '',
          ),
          EditProfileState(
            firstName: 'NourUpdated',
            lastName: initialUser.lastName ?? '',
            email: initialUser.email ?? '',
            phone: initialUser.phone ?? '',
            submitState: const BaseState<UserEntity>(isLoading: true),
          ),
          EditProfileState(
            firstName: 'NourUpdated',
            lastName: initialUser.lastName ?? '',
            email: initialUser.email ?? '',
            phone: initialUser.phone ?? '',
            submitState: BaseState<UserEntity>(
              isLoading: false,
              data: updatedUser,
            ),
          ),
        ];

        final done = expectLater(cubit.stream, emitsInOrder(expected));

        cubit.doEvent(const EditProfileFirstNameChanged('NourUpdated'));
        cubit.doEvent(const EditProfileSubmitted());

        await done;
        verify(
          mockUseCase.call(
            firstName: 'NourUpdated',
            lastName: initialUser.lastName,
            email: initialUser.email,
            phone: initialUser.phone,
          ),
        ).called(1);
      });

      test('emits loading then error when use case returns error', () async {
        when(
          mockUseCase.call(
            firstName: anyNamed('firstName'),
            lastName: anyNamed('lastName'),
            email: anyNamed('email'),
            phone: anyNamed('phone'),
          ),
        ).thenAnswer(
          (_) async => ErrorBaseResponse<UserEntity>(
            failure: Failure(message: 'fail'),
          ),
        );

        final expected = [
          EditProfileState(
            firstName: 'NourUpdated',
            lastName: initialUser.lastName ?? '',
            email: initialUser.email ?? '',
            phone: initialUser.phone ?? '',
          ),
          EditProfileState(
            firstName: 'NourUpdated',
            lastName: initialUser.lastName ?? '',
            email: initialUser.email ?? '',
            phone: initialUser.phone ?? '',
            submitState: const BaseState<UserEntity>(isLoading: true),
          ),
          EditProfileState(
            firstName: 'NourUpdated',
            lastName: initialUser.lastName ?? '',
            email: initialUser.email ?? '',
            phone: initialUser.phone ?? '',
            submitState: const BaseState<UserEntity>(
              isLoading: false,
              errorMessage: 'fail',
            ),
          ),
        ];

        final done = expectLater(cubit.stream, emitsInOrder(expected));

        cubit.doEvent(const EditProfileFirstNameChanged('NourUpdated'));
        cubit.doEvent(const EditProfileSubmitted());

        await done;
      });
    });
  });
}
