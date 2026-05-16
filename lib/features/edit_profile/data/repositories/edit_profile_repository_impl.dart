import 'dart:io';

import 'package:flower/config/base/base_response.dart';
import 'package:flower/core/network/model/user_models/user_entity.dart';
import 'package:flower/features/edit_profile/data/models/edit_profile_request.dart';
import 'package:flower/features/edit_profile/data/datasources/edit_profile_remote_data_source.dart';
import 'package:flower/features/edit_profile/domain/repositories/edit_profile_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: EditProfileRepository)
class EditProfileRepositoryImpl implements EditProfileRepository {
  final EditProfileRemoteDataSource _remoteDataSource;

  EditProfileRepositoryImpl(this._remoteDataSource);

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
    if (response is SuccessBaseResponse) {
      final dto = (response as SuccessBaseResponse).data;
      return SuccessBaseResponse<UserEntity>(data: dto.toDomain());
    }
    return ErrorBaseResponse<UserEntity>(
      failure: (response as ErrorBaseResponse).failure,
    );
  }

  @override
  Future<BaseResponse<UserEntity>> uploadPhoto(File photo) async {
    final response = await _remoteDataSource.uploadPhoto(photo);
    if (response is SuccessBaseResponse) {
      final dto = (response as SuccessBaseResponse).data;
      return SuccessBaseResponse<UserEntity>(data: dto.toDomain());
    }
    return ErrorBaseResponse<UserEntity>(
      failure: (response as ErrorBaseResponse).failure,
    );
  }
}

