import 'package:flower/config/base/base_response.dart';
import 'package:flower/core/error/error_handler.dart';
import 'package:flower/core/network/model/user.dart';
import 'package:flower/features/auth/api/api_client/auth_api_client.dart';
import 'package:flower/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:flower/features/auth/data/models/request/register_request.dart';
import 'package:flower/features/auth/domain/use_cases/register_params.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AuthRemoteDataSourceContract)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSourceContract {
  final AuthApiClient authApiClient;
  AuthRemoteDataSourceImpl({required this.authApiClient});
  @override
  Future<BaseResponse<UserDto>> register(RegisterParams params) async {
    try {
      final response = await authApiClient.register(
        RegisterRequestDto(
          firstName: params.firstName,
          lastName: params.lastName,
          email: params.email,
          password: params.password,
          rePassword: params.rePassword,
          phone: params.phone,
          gender: params.gender,
        ),
      );
      return SuccessBaseResponse<UserDto>(data: response.user!);
    } catch (e) {
      return ErrorBaseResponse<UserDto>(failure: ErrorHandler.handle(e));
    }
  }
}
