import 'dart:io';
import 'package:flower/config/base/base_response.dart';
import 'package:flower/core/network/model/user_entity.dart';
import 'package:flower/features/profile/domain/repositories/profile_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class UploadPhotoUseCase {
  final ProfileRepository _repository;

  UploadPhotoUseCase(this._repository);

  Future<BaseResponse<UserEntity>> call(File photo) async {
    return await _repository.uploadPhoto(photo);
  }
}
