import 'dart:io';

import 'package:flower/config/base/base_response.dart';
import 'package:flower/core/network/model/user_entity.dart';
import 'package:flower/features/profile/data/datasources/profile_remote_data_source.dart';
import 'package:flower/features/profile/data/models/edit_profile_request.dart';
import 'package:flower/features/profile/domain/repositories/profile_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ProfileRepository)
class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource _remoteDataSource;

  ProfileRepositoryImpl(this._remoteDataSource);

  @override
  Future<BaseResponse<UserEntity>> getProfile() async {
    final response = await _remoteDataSource.getProfile();
    return switch (response) {
      SuccessBaseResponse() => SuccessBaseResponse<UserEntity>(
        data: response.data.toDomain(),
      ),
      ErrorBaseResponse() => ErrorBaseResponse<UserEntity>(
        failure: response.failure,
      ),
    };
  }

  @override
  Future<BaseResponse<UserEntity>> editProfile({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
  }) async {
    final request = EditProfileRequestDto(
      firstName: firstName.trim(),
      lastName: lastName.trim(),
      email: email.trim(),
      phone: phone.trim(),
    );
    final response = await _remoteDataSource.editProfile(request);
    return switch (response) {
      SuccessBaseResponse() => SuccessBaseResponse<UserEntity>(
        data: response.data.toDomain(),
      ),
      ErrorBaseResponse() => ErrorBaseResponse<UserEntity>(
        failure: response.failure,
      ),
    };
  }

  @override
  Future<BaseResponse<UserEntity>> uploadPhoto(File photo) async {
    final response = await _remoteDataSource.uploadPhoto(photo);
    return switch (response) {
      SuccessBaseResponse() => SuccessBaseResponse<UserEntity>(
        data: response.data.toDomain(),
      ),
      ErrorBaseResponse() => ErrorBaseResponse<UserEntity>(
        failure: response.failure,
      ),
    };
  }
}
