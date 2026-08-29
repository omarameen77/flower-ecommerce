import 'dart:io';

import 'package:equatable/equatable.dart';

import 'package:flower/config/base/base_response.dart';
import 'package:flower/config/base/base_state.dart';
import 'package:flower/core/error/error_handler.dart';
import 'package:flower/core/network/model/user_entity.dart';
import 'package:flower/features/profile/domain/usecases/update_profile_use_case.dart';
import 'package:flower/features/profile/domain/usecases/upload_photo_use_case.dart';
import 'package:flower/features/profile/presentation/cubit/profile_edit_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_edit_state.dart';

class ProfileEditCubit extends Cubit<ProfileEditState> {
  ProfileEditCubit(
    this._useCase,
    this._uploadPhotoUseCase,
    UserEntity initialUser,
  ) : _initialFirst = (initialUser.firstName ?? '').trim(),
      _initialLast = (initialUser.lastName ?? '').trim(),
      _initialEmail = (initialUser.email ?? '').trim(),
      _initialPhone = (initialUser.phone ?? '').trim(),
      super(
        ProfileEditState(
          firstName: initialUser.firstName ?? '',
          lastName: initialUser.lastName ?? '',
          email: initialUser.email ?? '',
          phone: initialUser.phone ?? '',
          profilePhotoUrl: initialUser.photo,
        ),
      );

  final UpdateProfileUseCase _useCase;
  final UploadPhotoUseCase _uploadPhotoUseCase;
  final String _initialFirst;
  final String _initialLast;
  final String _initialEmail;
  final String _initialPhone;

  bool get hasChanges {
    final s = state;
    return s.firstName.trim() != _initialFirst ||
        s.lastName.trim() != _initialLast ||
        s.email.trim() != _initialEmail ||
        s.phone.trim() != _initialPhone ||
        s.photo != null;
  }

  void doEvent(ProfileEditEvent event) {
    switch (event) {
      case ProfileEditFirstNameChanged(:final value):
        emit(state.copyWith(firstName: value));
        break;
      case ProfileEditLastNameChanged(:final value):
        emit(state.copyWith(lastName: value));
        break;
      case ProfileEditEmailChanged(:final value):
        emit(state.copyWith(email: value));
        break;
      case ProfileEditPhoneChanged(:final value):
        emit(state.copyWith(phone: value));
        break;
      case ProfileEditPhotoChanged(:final file):
        _uploadPhoto(file);
        break;
      case ProfileEditSubmitted():
        _submit();
        break;
    }
  }

  Future<void> _uploadPhoto(File file) async {
    try {
      emit(
        state.copyWith(
          photo: file,
          uploadPhotoState: const BaseState(isLoading: true),
        ),
      );

      final result = await _uploadPhotoUseCase.call(file);

      switch (result) {
        case SuccessBaseResponse<UserEntity>():
          emit(
            state.copyWith(
              uploadPhotoState: BaseState(isLoading: false, data: result.data),
            ),
          );
        case ErrorBaseResponse<UserEntity>():
          emit(
            state.copyWith(
              uploadPhotoState: BaseState(
                isLoading: false,
                errorMessage: result.failure.message,
              ),
            ),
          );
      }
    } catch (e) {
      emit(
        state.copyWith(
          uploadPhotoState: BaseState(
            isLoading: false,
            errorMessage: ErrorHandler.handle(e).message,
          ),
        ),
      );
    }
  }

  Future<void> _submit() async {
    if (!hasChanges) return;

    try {
      emit(state.copyWith(submitState: const BaseState(isLoading: true)));

      final result = await _useCase.call(
        firstName: state.firstName,
        lastName: state.lastName,
        email: state.email,
        phone: state.phone,
      );

      switch (result) {
        case SuccessBaseResponse<UserEntity>():
          emit(
            state.copyWith(
              submitState: BaseState(isLoading: false, data: result.data),
            ),
          );
        case ErrorBaseResponse<UserEntity>():
          emit(
            state.copyWith(
              submitState: BaseState(
                isLoading: false,
                errorMessage: result.failure.message,
              ),
            ),
          );
      }
    } catch (e) {
      emit(
        state.copyWith(
          submitState: BaseState(
            isLoading: false,
            errorMessage: ErrorHandler.handle(e).message,
          ),
        ),
      );
    }
  }
}
