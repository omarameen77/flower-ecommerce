import 'package:flower/config/base/base_response.dart';
import 'package:flower/core/network/model/user_models/user.dart';

abstract class ProfileRemoteDataSource {
  Future<BaseResponse<UserDto>> getProfile();
}
