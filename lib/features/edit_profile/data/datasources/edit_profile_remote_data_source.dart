import 'package:flower/config/base/base_response.dart';
import 'package:flower/core/network/model/user_models/user.dart';
import 'package:flower/features/edit_profile/data/models/edit_profile_request.dart';

abstract class EditProfileRemoteDataSource {
  Future<BaseResponse<UserDto>> editProfile(EditProfileRequestDto request);
}
