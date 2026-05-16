import 'dart:io';
import 'package:flower/config/base/base_response.dart';
import 'package:flower/core/network/model/user_models/user_entity.dart';
import 'package:flower/features/edit_profile/domain/repositories/edit_profile_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class UploadPhotoUseCase {
  final EditProfileRepository _repository;

  UploadPhotoUseCase(this._repository);

  Future<BaseResponse<UserEntity>> call(File photo) async {
    return await _repository.uploadPhoto(photo);
  }
}
