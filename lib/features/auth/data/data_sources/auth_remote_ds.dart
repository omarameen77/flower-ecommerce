import 'package:flower/config/base/base_response.dart';
import 'package:flower/features/auth/data/models/response/forget_password_response.dart';
import 'package:flower/features/auth/data/models/response/reset_password_response.dart';
import 'package:flower/features/auth/data/models/response/verify_reset_code_response.dart';

abstract class AuthRemoteDs {
  Future<BaseResponse<ForgetPasswordResponseDto>> forgetPassword({
    required String email,
  });

  Future<BaseResponse<VerifyResetCodeResponseDto>> verifyResetCode({
    required String resetCode,
  });

  Future<BaseResponse<ResetPasswordResponseDto>> resetPassword({
    required String email,
    required String newPassword,
  });
}
