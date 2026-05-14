import 'package:flower/config/base/base_response.dart';
import 'package:flower/core/network/model/user_models/user_entity.dart';

abstract class EditProfileRepository {
  Future<BaseResponse<UserEntity>> editProfile({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
  });
}
