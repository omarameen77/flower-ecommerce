import 'package:flower/config/base/base_response.dart';
import 'package:flower/core/network/model/user_entity.dart';
import 'package:flower/features/auth/domain/usecases/register_params.dart';

abstract class AuthRepo {
  Future<BaseResponse<UserEntity>> register(RegisterParams params);
}
