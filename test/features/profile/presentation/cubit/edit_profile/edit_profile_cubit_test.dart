import 'dart:io';

import 'package:flower/config/base/base_response.dart';
import 'package:flower/core/error/error_handler.dart';
import 'package:flower/core/network/model/user_entity.dart';
import 'package:flower/features/profile/domain/usecases/update_profile_use_case.dart';
import 'package:flower/features/profile/domain/usecases/upload_photo_use_case.dart';
import 'package:flower/features/profile/presentation/cubit/profile_edit_cubit.dart';
import 'package:flower/features/profile/presentation/cubit/profile_edit_event.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'edit_profile_cubit_test.mocks.dart';

@GenerateMocks([UpdateProfileUseCase, UploadPhotoUseCase])
void main() {
  late ProfileEditCubit profileEditCubit;
  late MockUpdateProfileUseCase mockUpdateProfileUseCase;
  late MockUploadPhotoUseCase mockUploadPhotoUseCase;
  late UserEntity tInitialUser;

  setUpAll(() {
    provideDummy<BaseResponse<UserEntity>>(
      SuccessBaseResponse<UserEntity>(
        data: UserEntity(email: "test@example.com"),
      ),
    );
  });

  setUp(() {
    mockUpdateProfileUseCase = MockUpdateProfileUseCase();
    mockUploadPhotoUseCase = MockUploadPhotoUseCase();
    tInitialUser = UserEntity(
      id: "1",
      firstName: "John",
      lastName: "Doe",
      email: "john.doe@example.com",
      phone: "1234567890",
    );
    profileEditCubit = ProfileEditCubit(
      mockUpdateProfileUseCase,
      mockUploadPhotoUseCase,
      tInitialUser,
    );
  });

  tearDown(() {
    profileEditCubit.close();
  });

  group('ProfileEditCubit', () {
    test('initial state is correct', () {
      expect(profileEditCubit.state.firstName, tInitialUser.firstName);
      expect(profileEditCubit.state.lastName, tInitialUser.lastName);
      expect(profileEditCubit.state.email, tInitialUser.email);
      expect(profileEditCubit.state.phone, tInitialUser.phone);
      expect(profileEditCubit.hasChanges, false);
    });

    group('Field Changes', () {
      test('updates first name and hasChanges is true', () {
        profileEditCubit.doEvent(const ProfileEditFirstNameChanged("Jane"));
        expect(profileEditCubit.state.firstName, "Jane");
        expect(profileEditCubit.hasChanges, true);
      });

      test('updates last name and hasChanges is true', () {
        profileEditCubit.doEvent(const ProfileEditLastNameChanged("Smith"));
        expect(profileEditCubit.state.lastName, "Smith");
        expect(profileEditCubit.hasChanges, true);
      });

      test('updates email and hasChanges is true', () {
        profileEditCubit.doEvent(
          const ProfileEditEmailChanged("jane@example.com"),
        );
        expect(profileEditCubit.state.email, "jane@example.com");
        expect(profileEditCubit.hasChanges, true);
      });

      test('updates phone and hasChanges is true', () {
        profileEditCubit.doEvent(const ProfileEditPhoneChanged("0987654321"));
        expect(profileEditCubit.state.phone, "0987654321");
        expect(profileEditCubit.hasChanges, true);
      });
    });

    group('ProfileEditPhotoChanged', () {
      test('emits loading then success when upload is successful', () async {
        final tFile = File('test.png');
        final tUser = UserEntity(id: "1", photo: "new_photo_url");

        when(
          mockUploadPhotoUseCase.call(tFile),
        ).thenAnswer((_) async => SuccessBaseResponse<UserEntity>(data: tUser));

        profileEditCubit.doEvent(ProfileEditPhotoChanged(tFile));

        expect(profileEditCubit.state.uploadPhotoState.isLoading, true);
        expect(profileEditCubit.state.photo, tFile);
        expect(profileEditCubit.hasChanges, true);

        await Future.delayed(Duration.zero);

        expect(profileEditCubit.state.uploadPhotoState.isLoading, false);
        expect(profileEditCubit.state.uploadPhotoState.data, tUser);
        verify(mockUploadPhotoUseCase.call(tFile)).called(1);
      });

      test('emits loading then error when upload fails', () async {
        final tFile = File('test.png');
        final tFailure = Failure(message: 'Upload error');

        when(mockUploadPhotoUseCase.call(tFile)).thenAnswer(
          (_) async => ErrorBaseResponse<UserEntity>(failure: tFailure),
        );

        profileEditCubit.doEvent(ProfileEditPhotoChanged(tFile));

        expect(profileEditCubit.state.uploadPhotoState.isLoading, true);

        await Future.delayed(Duration.zero);

        expect(profileEditCubit.state.uploadPhotoState.isLoading, false);
        expect(
          profileEditCubit.state.uploadPhotoState.errorMessage,
          'Upload error',
        );
      });
    });

    group('ProfileEditSubmitted', () {
      test('does not call use case if hasChanges is false', () async {
        profileEditCubit.doEvent(const ProfileEditSubmitted());
        verifyNever(
          mockUpdateProfileUseCase.call(
            firstName: anyNamed('firstName'),
            lastName: anyNamed('lastName'),
            email: anyNamed('email'),
            phone: anyNamed('phone'),
          ),
        );
      });

      test('emits loading then success when submit is successful', () async {
        profileEditCubit.doEvent(const ProfileEditFirstNameChanged("Jane"));

        final tUser = UserEntity(id: "1", firstName: "Jane", lastName: "Doe");
        when(
          mockUpdateProfileUseCase.call(
            firstName: "Jane",
            lastName: "Doe",
            email: "john.doe@example.com",
            phone: "1234567890",
          ),
        ).thenAnswer((_) async => SuccessBaseResponse<UserEntity>(data: tUser));

        profileEditCubit.doEvent(const ProfileEditSubmitted());

        expect(profileEditCubit.state.submitState.isLoading, true);

        await Future.delayed(Duration.zero);

        expect(profileEditCubit.state.submitState.isLoading, false);
        expect(profileEditCubit.state.submitState.data, tUser);
        verify(
          mockUpdateProfileUseCase.call(
            firstName: "Jane",
            lastName: "Doe",
            email: "john.doe@example.com",
            phone: "1234567890",
          ),
        ).called(1);
      });

      test('emits loading then error when submit fails', () async {
        profileEditCubit.doEvent(const ProfileEditFirstNameChanged("Jane"));

        final tFailure = Failure(message: 'Update error');
        when(
          mockUpdateProfileUseCase.call(
            firstName: "Jane",
            lastName: "Doe",
            email: "john.doe@example.com",
            phone: "1234567890",
          ),
        ).thenAnswer(
          (_) async => ErrorBaseResponse<UserEntity>(failure: tFailure),
        );

        profileEditCubit.doEvent(const ProfileEditSubmitted());

        expect(profileEditCubit.state.submitState.isLoading, true);

        await Future.delayed(Duration.zero);

        expect(profileEditCubit.state.submitState.isLoading, false);
        expect(profileEditCubit.state.submitState.errorMessage, 'Update error');
      });
    });
  });
}
