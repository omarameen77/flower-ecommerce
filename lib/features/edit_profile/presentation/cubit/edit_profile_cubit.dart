import 'dart:io';

import 'package:equatable/equatable.dart';

import 'package:flower/config/base/base_response.dart';
import 'package:flower/config/base/base_state.dart';
import 'package:flower/core/error/error_handler.dart';
import 'package:flower/core/network/model/user_models/user_entity.dart';
import 'package:flower/features/edit_profile/domain/usecases/edit_profile_use_case.dart';
import 'package:flower/features/edit_profile/domain/usecases/upload_photo_use_case.dart';
import 'package:flower/features/edit_profile/presentation/cubit/edit_profile_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit(
    this._useCase,
    this._uploadPhotoUseCase,
    UserEntity initialUser,
  ) : _initialFirst = (initialUser.firstName ?? '').trim(),
      _initialLast = (initialUser.lastName ?? '').trim(),
      _initialEmail = (initialUser.email ?? '').trim(),
      _initialPhone = (initialUser.phone ?? '').trim(),
      super(
        EditProfileState(
          firstName: initialUser.firstName ?? '',
          lastName: initialUser.lastName ?? '',
          email: initialUser.email ?? '',
          phone: initialUser.phone ?? '',
          profilePhotoUrl: initialUser.photo,
        ),
      );


  final EditProfileUseCase _useCase;
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

  void doEvent(EditProfileEvent event) {
    switch (event) {
      case EditProfileFirstNameChanged(:final value):
        emit(state.copyWith(firstName: value));
        break;
      case EditProfileLastNameChanged(:final value):
        emit(state.copyWith(lastName: value));
        break;
      case EditProfileEmailChanged(:final value):
        emit(state.copyWith(email: value));
        break;
      case EditProfilePhoneChanged(:final value):
        emit(state.copyWith(phone: value));
        break;
      case EditProfilePhotoChanged(:final file):
        _uploadPhoto(file);
        break;
      case EditProfileSubmitted():
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

      if (result is SuccessBaseResponse<UserEntity>) {
        emit(
          state.copyWith(
            uploadPhotoState: BaseState(isLoading: false, data: result.data),
          ),
        );
      } else if (result is ErrorBaseResponse<UserEntity>) {
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

      if (result is SuccessBaseResponse<UserEntity>) {
        emit(
          state.copyWith(
            submitState: BaseState(isLoading: false, data: result.data),
          ),
        );
      } else if (result is ErrorBaseResponse<UserEntity>) {
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

