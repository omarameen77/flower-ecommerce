/*
UNIT TESTING STEPS
1. ARRANGE
2. ACT
3. ASSERT

ProfileCubit — doEvent(ProfileEvent)

Cases:
1. ProfileOpened — updates languageCode then loads profile: loading → success
2. ProfileOpened — load profile error: loading → error
3. LoadProfile — loading → success
4. ToggleLanguage — toggles languageCode en ↔ ar
5. NotificationsChanged — updates flag
6. LogoutRequested — logout loading → success (requires platform secure storage)

Dependency: GetProfileUseCase (mock)
*/

import 'package:flower/config/base/base_response.dart';
import 'package:flower/config/base/base_state.dart';
import 'package:flower/core/error/error_handler.dart';
import 'package:flower/core/network/model/user_models/user_entity.dart';
import 'package:flower/core/profile/domain/usecases/get_profile_use_case.dart';
import 'package:flower/features/profile/presentation/cubit/get_user_data/profile_cubit.dart';
import 'package:flower/features/profile/presentation/cubit/get_user_data/profile_event.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'profile_cubit_test.mocks.dart';

@GenerateMocks([GetProfileUseCase])
void main() {
  late MockGetProfileUseCase mockGetProfileUseCase;
  late ProfileCubit profileCubit;

  late UserEntity userEntity;

  setUpAll(() {
    provideDummy<BaseResponse<UserEntity>>(
      SuccessBaseResponse<UserEntity>(
        data: UserEntity(email: 'test@test.com'),
      ),
    );
  });

  setUp(() {
    mockGetProfileUseCase = MockGetProfileUseCase();
    profileCubit = ProfileCubit(mockGetProfileUseCase);

    userEntity = UserEntity(
      firstName: 'Nour',
      email: 'nour@test.com',
    );
  });

  tearDown(() {
    profileCubit.close();
  });

  group('profile cubit', () {
    group('ProfileOpened', () {
      test(
        'emits language then loading then success when getProfile succeeds',
        () async {
          // ARRANGE
          when(mockGetProfileUseCase.call()).thenAnswer(
            (_) async => SuccessBaseResponse<UserEntity>(data: userEntity),
          );

          final expected = [
            const ProfileState(languageCode: 'ar'),
            const ProfileState(
              languageCode: 'ar',
              profileState: BaseState<UserEntity>(isLoading: true),
            ),
            ProfileState(
              languageCode: 'ar',
              profileState: BaseState<UserEntity>(
                isLoading: false,
                data: userEntity,
              ),
            ),
          ];

          // ASSERT (subscribe before ACT)
          final done = expectLater(
            profileCubit.stream,
            emitsInOrder(expected),
          );

          // ACT
          profileCubit.doEvent(ProfileOpened(languageCode: 'ar'));

          await done;
          verify(mockGetProfileUseCase.call()).called(1);
        },
      );

      test(
        'emits language then loading then error when getProfile fails',
        () async {
          // ARRANGE
          when(mockGetProfileUseCase.call()).thenAnswer(
            (_) async => ErrorBaseResponse<UserEntity>(
              failure: Failure(message: 'fail'),
            ),
          );

          final expected = [
            const ProfileState(languageCode: 'fr'),
            const ProfileState(
              languageCode: 'fr',
              profileState: BaseState<UserEntity>(isLoading: true),
            ),
            const ProfileState(
              languageCode: 'fr',
              profileState: BaseState<UserEntity>(
                isLoading: false,
                errorMessage: 'fail',
              ),
            ),
          ];

          final done = expectLater(
            profileCubit.stream,
            emitsInOrder(expected),
          );

          profileCubit.doEvent(ProfileOpened(languageCode: 'fr'));

          await done;
        },
      );
    });

    group('LoadProfile', () {
      test('emits loading then success', () async {
        // ARRANGE
        when(mockGetProfileUseCase.call()).thenAnswer(
          (_) async => SuccessBaseResponse<UserEntity>(data: userEntity),
        );

        final expected = [
          const ProfileState(
            profileState: BaseState<UserEntity>(isLoading: true),
          ),
          ProfileState(
            profileState: BaseState<UserEntity>(
              isLoading: false,
              data: userEntity,
            ),
          ),
        ];

        final done = expectLater(profileCubit.stream, emitsInOrder(expected));

        profileCubit.doEvent(const LoadProfile());

        await done;
        verify(mockGetProfileUseCase.call()).called(1);
      });
    });

    group('ToggleLanguage', () {
      test('toggles en to ar', () async {
        final done = expectLater(
          profileCubit.stream,
          emitsInOrder([const ProfileState(languageCode: 'ar')]),
        );

        profileCubit.doEvent(const ToggleLanguage());

        await done;
        verifyNever(mockGetProfileUseCase.call());
      });
    });

    group('NotificationsChanged', () {
      test('updates notificationsEnabled', () async {
        final done = expectLater(
          profileCubit.stream,
          emitsInOrder([const ProfileState(notificationsEnabled: false)]),
        );

        profileCubit.doEvent(NotificationsChanged(false));

        await done;
      });
    });
  });
}
