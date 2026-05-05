import 'package:flower/config/base/base_response.dart';
import 'package:flower/core/network/safe_api_caller.dart';
import 'package:flower/features/auth/api/auth_api.dart';
import 'package:flower/features/auth/data/data_sources/auth_remote_ds.dart';
import 'package:flower/features/auth/data/models/request/forget_password_request.dart';
import 'package:flower/features/auth/data/models/request/reset_password_request.dart';
import 'package:flower/features/auth/data/models/request/verify_reset_code_request.dart';
import 'package:flower/features/auth/data/models/response/forget_password_response.dart';
import 'package:flower/features/auth/data/models/response/reset_password_response.dart';
import 'package:flower/features/auth/data/models/response/verify_reset_code_response.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRemoteDs)
class AuthRemoteDsImpl implements AuthRemoteDs {
  final AuthApi _api;
  final SafeApiCaller _safeApiCaller;

  AuthRemoteDsImpl(this._api, this._safeApiCaller);

  @override
  Future<BaseResponse<ForgetPasswordResponseDto>> forgetPassword({
    required String email,
  }) {
    return _safeApiCaller.safeCall(
      () => _api.forgotPassword(ForgetPasswordRequestDto(email: email)),
    );
  }

  @override
  Future<BaseResponse<VerifyResetCodeResponseDto>> verifyResetCode({
    required String resetCode,
  }) {
    return _safeApiCaller.safeCall(
      () => _api.verifyResetCode(
        VerifyResetCodeRequestDto(resetCode: resetCode),
      ),
    );
  }

  @override
  Future<BaseResponse<ResetPasswordResponseDto>> resetPassword({
    required String email,
    required String newPassword,
  }) {
    return _safeApiCaller.safeCall(
      () => _api.resetPassword(
        ResetPasswordRequestDto(email: email, newPassword: newPassword),
      ),
    );
  }
}
