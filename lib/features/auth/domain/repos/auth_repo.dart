import 'package:flower/config/base/base_response.dart';
import 'package:flower/features/auth/domain/models/forget_password_entity.dart';
import 'package:flower/features/auth/domain/models/reset_password_entity.dart';
import 'package:flower/features/auth/domain/models/verify_reset_code_entity.dart';

abstract class AuthRepo {
  Future<BaseResponse<ForgetPasswordEntity>> forgetPassword({
    required String email,
  });

  Future<BaseResponse<VerifyResetCodeEntity>> verifyResetCode({
    required String resetCode,
  });

  Future<BaseResponse<ResetPasswordEntity>> resetPassword({
    required String email,
    required String newPassword,
  });
}
