import 'package:flower/config/base/base_response.dart';
import 'package:flower/core/network/model/user_models/user_entity.dart';

abstract class ProfileRepository {
  Future<BaseResponse<UserEntity>> getProfile();
}
