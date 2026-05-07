import 'package:flower/config/base/base_response.dart';
import 'package:flower/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:flower/features/auth/data/models/response/forget_password_response.dart';
import 'package:flower/features/auth/data/models/response/reset_password_response.dart';
import 'package:flower/features/auth/data/models/response/verify_reset_code_response.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRemoteDs)
class AuthRemoteDsImpl implements AuthRemoteDs {
  AuthRemoteDsImpl();

  static const _fakeDelay = Duration(milliseconds: 500);

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
