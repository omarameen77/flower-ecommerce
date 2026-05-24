import 'package:flower/config/base/base_response.dart';
import 'package:flower/config/base/base_state.dart';
import 'package:flower/core/error/error_handler.dart';
import 'package:flower/core/network/model/user_entity.dart';
import 'package:flower/core/profile/domain/usecases/get_profile_use_case.dart';
import 'package:flower/features/profile/presentation/cubit/get_user_data/profile_cubit.dart';
import 'package:flower/features/profile/presentation/cubit/get_user_data/profile_event.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'profile_cubit_test.mocks.dart';

@GenerateMocks([GetProfileUseCase])
void main() {
  late ProfileCubit profileCubit;
  late MockGetProfileUseCase mockGetProfileUseCase;

  setUpAll(() {
    FlutterSecureStorage.setMockInitialValues({});
    provideDummy<BaseResponse<UserEntity>>(
      SuccessBaseResponse<UserEntity>(data: UserEntity(email: "test@example.com")),
    );
  });

  setUp(() {
    mockGetProfileUseCase = MockGetProfileUseCase();
    profileCubit = ProfileCubit(mockGetProfileUseCase);
  });

  tearDown(() {
    profileCubit.close();
  });

  group('ProfileCubit', () {
    test('initial state is correct', () {
      expect(profileCubit.state, const ProfileState());
    });

    group('ToggleLanguage', () {
      test('toggles language from en to ar', () {
        profileCubit.doEvent(const ToggleLanguage());
        expect(profileCubit.state.languageCode, 'ar');
      });

      test('toggles language from ar to en', () {
        // First switch to ar
        profileCubit.doEvent(const ToggleLanguage());
        // Switch back to en
        profileCubit.doEvent(const ToggleLanguage());
        expect(profileCubit.state.languageCode, 'en');
      });
    });

    group('NotificationsChanged', () {
      test('updates notifications enabled state', () {
        profileCubit.doEvent(NotificationsChanged(false));
        expect(profileCubit.state.notificationsEnabled, false);

        profileCubit.doEvent(NotificationsChanged(true));
        expect(profileCubit.state.notificationsEnabled, true);
      });
    });

    group('ProfileOpened', () {
      test('emits language code and loads profile', () async {
        final tUser = UserEntity(email: "test@example.com", id: "1");
        
        when(mockGetProfileUseCase.call())
            .thenAnswer((_) async => SuccessBaseResponse<UserEntity>(data: tUser));

        profileCubit.doEvent(ProfileOpened(languageCode: 'ar'));

        expect(profileCubit.state.languageCode, 'ar');
        expect(profileCubit.state.profileState.isLoading, true);

        // Wait for microtasks to finish the async call
        await Future.delayed(Duration.zero);

        expect(profileCubit.state.profileState.isLoading, false);
        expect(profileCubit.state.profileState.data, tUser);
      });
    });

    group('LoadProfile', () {
      test('emits loading then success when use case returns SuccessBaseResponse', () async {
        final tUser = UserEntity(email: "test@example.com", id: "1");
        
        when(mockGetProfileUseCase.call())
            .thenAnswer((_) async => SuccessBaseResponse<UserEntity>(data: tUser));

        profileCubit.doEvent(const LoadProfile());

        expect(profileCubit.state.profileState.isLoading, true);

        await Future.delayed(Duration.zero);

        expect(profileCubit.state.profileState.isLoading, false);
        expect(profileCubit.state.profileState.data, tUser);
        verify(mockGetProfileUseCase.call()).called(1);
      });

      test('emits loading then error when use case returns ErrorBaseResponse', () async {
        final tFailure = Failure(message: 'Profile Error');
        
        when(mockGetProfileUseCase.call())
            .thenAnswer((_) async => ErrorBaseResponse<UserEntity>(failure: tFailure));

        profileCubit.doEvent(const LoadProfile());

        expect(profileCubit.state.profileState.isLoading, true);

        await Future.delayed(Duration.zero);

        expect(profileCubit.state.profileState.isLoading, false);
        expect(profileCubit.state.profileState.errorMessage, 'Profile Error');
      });

      test('emits loading then error when use case throws exception', () async {
        when(mockGetProfileUseCase.call())
            .thenAnswer((_) async {
              await Future.delayed(const Duration(milliseconds: 10));
              throw Exception('Unexpected error');
            });

        profileCubit.doEvent(const LoadProfile());

        expect(profileCubit.state.profileState.isLoading, true);

        await Future.delayed(const Duration(milliseconds: 20));

        expect(profileCubit.state.profileState.isLoading, false);
        expect(profileCubit.state.profileState.errorMessage, isNotNull);
      });
    });

    group('LogoutRequested', () {
      test('emits loading then success when logout is requested', () async {
        profileCubit.doEvent(const LogoutRequested());

        expect(profileCubit.state.logoutState.isLoading, true);

        await Future.delayed(Duration.zero);

        expect(profileCubit.state.logoutState.isLoading, false);
        expect(profileCubit.state.logoutState.data, true);
      });
    });
  });
}
