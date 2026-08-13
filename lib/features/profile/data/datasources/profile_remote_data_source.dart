import 'dart:io';

import 'package:flower/config/base/base_response.dart';
import 'package:flower/core/network/model/user.dart';
import 'package:flower/features/profile/data/models/edit_profile_request.dart';

abstract class ProfileRemoteDataSource {
  Future<BaseResponse<UserDto>> getProfile();
  Future<BaseResponse<UserDto>> editProfile(EditProfileRequestDto request);
  Future<BaseResponse<UserDto>> uploadPhoto(File photo);
}
