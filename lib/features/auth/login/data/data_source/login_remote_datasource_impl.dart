import 'package:flower/config/base/base_response.dart';
import 'package:flower/core/network/safe_api_caller.dart';
import 'package:flower/features/auth/api/auth_api.dart';
import 'package:flower/features/auth/data/models/request/login_request.dart';
import 'package:flower/features/auth/login/data/data_source/login_remote_datasource.dart';
import 'package:flower/features/auth/login/data/model/login_request_dto.dart';
import 'package:flower/features/auth/login/domain/entity/login_response.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: LoginRemoteDataSourceContract)
class LoginRemoteDatasourceImpl implements LoginRemoteDataSourceContract {
  final AuthApi authApi;
  final SafeApiCaller executor;

  LoginRemoteDatasourceImpl(this.authApi, this.executor);

  @override
  Future<BaseResponse<LoginResponse>> login(LoginRequestDTO request) {
    return executor.safeCall<LoginResponse>(() async {
      final response = await authApi.login(
        LoginRequestDto(email: request.email, password: request.password),
      );
final dto = response;

      return LoginResponse(
        message: dto.message,
        token: dto.token,
        user: dto.user!.toDomain(),
      );
    });
  }
}
