import 'package:flower/config/base/base_response.dart';
import 'package:flower/core/error/error_handler.dart';
import 'package:flower/core/network/model/user.dart';
import 'package:flower/features/auth/api/api_client/auth_api_client.dart';
import 'package:flower/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:flower/features/auth/data/models/request/register_request.dart';
import 'package:flower/features/auth/data/models/response/forget_password_response.dart';
import 'package:flower/features/auth/data/models/response/reset_password_response.dart';
import 'package:flower/features/auth/data/models/response/verify_reset_code_response.dart';
import 'package:flower/features/auth/domain/use_cases/register_params.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AuthRemoteDataSourceContract)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSourceContract {
  final AuthApiClient authApiClient;

  AuthRemoteDataSourceImpl({required this.authApiClient});

  static const _fakeDelay = Duration(milliseconds: 500);

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

  @override
  Future<BaseResponse<ForgetPasswordResponseDto>> forgetPassword({
    required String email,
  }) async {
    await Future.delayed(_fakeDelay);
    return SuccessBaseResponse(
      data: ForgetPasswordResponseDto(
        message: 'Code sent (static)',
        info: 'check email (static)',
      ),
    );
  }

  @override
  Future<BaseResponse<VerifyResetCodeResponseDto>> verifyResetCode({
    required String resetCode,
  }) async {
    await Future.delayed(_fakeDelay);
    final ok = resetCode == '1234';
    return SuccessBaseResponse(
      data: VerifyResetCodeResponseDto(status: ok ? 'Success' : 'Fail'),
    );
  }

  @override
  Future<BaseResponse<ResetPasswordResponseDto>> resetPassword({
    required String email,
    required String newPassword,
  }) async {
    await Future.delayed(_fakeDelay);
    return SuccessBaseResponse(
      data: ResetPasswordResponseDto(
        message: 'Password reset (static)',
        token: 'fake-token',
      ),
    );
  }
}
