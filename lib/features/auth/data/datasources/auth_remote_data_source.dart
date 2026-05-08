import 'package:flower/config/base/base_response.dart';
import 'package:flower/core/network/model/user.dart';

import 'package:flower/features/auth/domain/use_cases/register_params.dart';

abstract class AuthRemoteDataSourceContract {
  Future<BaseResponse<UserDto>> register(RegisterParams params);
}
