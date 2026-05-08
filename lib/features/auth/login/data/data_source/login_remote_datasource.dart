import 'package:flower/config/base/base_response.dart';
import 'package:flower/features/auth/login/data/model/login_request_dto.dart';
import 'package:flower/features/auth/login/domain/entity/login_response.dart';

abstract class LoginRemoteDataSourceContract {
  Future<BaseResponse<LoginResponse>> login(LoginRequestDTO loginRequest);
}
