import 'dart:io';

import 'package:flower/config/base/base_response.dart';
import 'package:flower/core/error/error_handler.dart';
import 'package:flower/core/network/model/user_entity.dart';
import 'package:flower/features/edit_profile/domain/usecases/edit_profile_use_case.dart';
import 'package:flower/features/edit_profile/domain/usecases/upload_photo_use_case.dart';
import 'package:flower/features/edit_profile/presentation/cubit/edit_profile_cubit.dart';
import 'package:flower/features/edit_profile/presentation/cubit/edit_profile_event.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'edit_profile_cubit_test.mocks.dart';

@GenerateMocks([EditProfileUseCase, UploadPhotoUseCase])
void main() {
  late EditProfileCubit editProfileCubit;
  late MockEditProfileUseCase mockEditProfileUseCase;
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
    mockEditProfileUseCase = MockEditProfileUseCase();
    mockUploadPhotoUseCase = MockUploadPhotoUseCase();
    tInitialUser = UserEntity(
      id: "1",
      firstName: "John",
      lastName: "Doe",
      email: "john.doe@example.com",
      phone: "1234567890",
    );
    editProfileCubit = EditProfileCubit(
      mockEditProfileUseCase,
      mockUploadPhotoUseCase,
      tInitialUser,
    );
  });

  tearDown(() {
    editProfileCubit.close();
  });

  group('EditProfileCubit', () {
    test('initial state is correct', () {
      expect(editProfileCubit.state.firstName, tInitialUser.firstName);
      expect(editProfileCubit.state.lastName, tInitialUser.lastName);
      expect(editProfileCubit.state.email, tInitialUser.email);
      expect(editProfileCubit.state.phone, tInitialUser.phone);
      expect(editProfileCubit.hasChanges, false);
    });

    group('Field Changes', () {
      test('updates first name and hasChanges is true', () {
        editProfileCubit.doEvent(const EditProfileFirstNameChanged("Jane"));
        expect(editProfileCubit.state.firstName, "Jane");
        expect(editProfileCubit.hasChanges, true);
      });

      test('updates last name and hasChanges is true', () {
        editProfileCubit.doEvent(const EditProfileLastNameChanged("Smith"));
        expect(editProfileCubit.state.lastName, "Smith");
        expect(editProfileCubit.hasChanges, true);
      });

      test('updates email and hasChanges is true', () {
        editProfileCubit.doEvent(
          const EditProfileEmailChanged("jane@example.com"),
        );
        expect(editProfileCubit.state.email, "jane@example.com");
        expect(editProfileCubit.hasChanges, true);
      });

      test('updates phone and hasChanges is true', () {
        editProfileCubit.doEvent(const EditProfilePhoneChanged("0987654321"));
        expect(editProfileCubit.state.phone, "0987654321");
        expect(editProfileCubit.hasChanges, true);
      });
    });

    group('EditProfilePhotoChanged', () {
      test('emits loading then success when upload is successful', () async {
        final tFile = File('test.png');
        final tUser = UserEntity(id: "1", photo: "new_photo_url");

        when(
          mockUploadPhotoUseCase.call(tFile),
        ).thenAnswer((_) async => SuccessBaseResponse<UserEntity>(data: tUser));

        editProfileCubit.doEvent(EditProfilePhotoChanged(tFile));

        expect(editProfileCubit.state.uploadPhotoState.isLoading, true);
        expect(editProfileCubit.state.photo, tFile);
        expect(editProfileCubit.hasChanges, true);

        await Future.delayed(Duration.zero);

        expect(editProfileCubit.state.uploadPhotoState.isLoading, false);
        expect(editProfileCubit.state.uploadPhotoState.data, tUser);
        verify(mockUploadPhotoUseCase.call(tFile)).called(1);
      });

      test('emits loading then error when upload fails', () async {
        final tFile = File('test.png');
        final tFailure = Failure(message: 'Upload error');

        when(mockUploadPhotoUseCase.call(tFile)).thenAnswer(
          (_) async => ErrorBaseResponse<UserEntity>(failure: tFailure),
        );

        editProfileCubit.doEvent(EditProfilePhotoChanged(tFile));

        expect(editProfileCubit.state.uploadPhotoState.isLoading, true);

        await Future.delayed(Duration.zero);

        expect(editProfileCubit.state.uploadPhotoState.isLoading, false);
        expect(
          editProfileCubit.state.uploadPhotoState.errorMessage,
          'Upload error',
        );
      });
    });

    group('EditProfileSubmitted', () {
      test('does not call use case if hasChanges is false', () async {
        editProfileCubit.doEvent(const EditProfileSubmitted());
        verifyNever(
          mockEditProfileUseCase.call(
            firstName: anyNamed('firstName'),
            lastName: anyNamed('lastName'),
            email: anyNamed('email'),
            phone: anyNamed('phone'),
          ),
        );
      });

      test('emits loading then success when submit is successful', () async {
        // Change a field to make hasChanges true
        editProfileCubit.doEvent(const EditProfileFirstNameChanged("Jane"));

        final tUser = UserEntity(id: "1", firstName: "Jane", lastName: "Doe");
        when(
          mockEditProfileUseCase.call(
            firstName: "Jane",
            lastName: "Doe",
            email: "john.doe@example.com",
            phone: "1234567890",
          ),
        ).thenAnswer((_) async => SuccessBaseResponse<UserEntity>(data: tUser));

        editProfileCubit.doEvent(const EditProfileSubmitted());

        expect(editProfileCubit.state.submitState.isLoading, true);

        await Future.delayed(Duration.zero);

        expect(editProfileCubit.state.submitState.isLoading, false);
        expect(editProfileCubit.state.submitState.data, tUser);
        verify(
          mockEditProfileUseCase.call(
            firstName: "Jane",
            lastName: "Doe",
            email: "john.doe@example.com",
            phone: "1234567890",
          ),
        ).called(1);
      });

      test('emits loading then error when submit fails', () async {
        editProfileCubit.doEvent(const EditProfileFirstNameChanged("Jane"));

        final tFailure = Failure(message: 'Update error');
        when(
          mockEditProfileUseCase.call(
            firstName: "Jane",
            lastName: "Doe",
            email: "john.doe@example.com",
            phone: "1234567890",
          ),
        ).thenAnswer(
          (_) async => ErrorBaseResponse<UserEntity>(failure: tFailure),
        );

        editProfileCubit.doEvent(const EditProfileSubmitted());

        expect(editProfileCubit.state.submitState.isLoading, true);

        await Future.delayed(Duration.zero);

        expect(editProfileCubit.state.submitState.isLoading, false);
        expect(editProfileCubit.state.submitState.errorMessage, 'Update error');
      });
    });
  });
}
