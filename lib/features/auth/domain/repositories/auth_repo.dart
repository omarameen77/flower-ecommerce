import 'package:flower/config/base/base_response.dart';
import 'package:flower/core/network/model/user_models/user_entity.dart';
import 'package:flower/features/auth/domain/entities/forget_password_entity.dart';
import 'package:flower/features/auth/domain/entities/reset_password_entity.dart';
import 'package:flower/features/auth/domain/entities/verify_reset_code_entity.dart';
import 'package:flower/features/auth/domain/use_cases/login_params.dart';
import 'package:flower/features/auth/domain/use_cases/register_params.dart';

abstract class AuthRepo {
  Future<BaseResponse<UserEntity>> login(LoginParams params);

  Future<BaseResponse<UserEntity>> register(RegisterParams params);

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
