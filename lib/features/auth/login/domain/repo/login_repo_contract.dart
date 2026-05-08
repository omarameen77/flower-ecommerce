import 'package:flower/config/base/base_response.dart';
import 'package:flower/features/auth/login/domain/entity/login_request.dart';
import 'package:flower/features/auth/login/domain/entity/login_response.dart';

abstract class LoginRepoContract {
 Future<BaseResponse<LoginResponse>> login(LoginRequest request);
}