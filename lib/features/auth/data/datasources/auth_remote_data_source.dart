import 'package:flower/config/base/base_response.dart';
import 'package:flower/core/network/model/user.dart';
import 'package:flower/features/auth/data/models/response/change_password_response.dart';
import 'package:flower/features/auth/data/models/response/forget_password_response.dart';
import 'package:flower/features/auth/data/models/response/reset_password_response.dart';
import 'package:flower/features/auth/data/models/response/verify_reset_code_response.dart';
import 'package:flower/features/auth/domain/use_cases/login_params.dart';
import 'package:flower/features/auth/domain/use_cases/register_params.dart';

abstract class AuthRemoteDataSourceContract {
  Future<BaseResponse<UserDto>> login(LoginParams params);

  Future<BaseResponse<UserDto>> register(RegisterParams params);

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

  Future<BaseResponse<ChangePasswordResponseDto>> changePassword({
    required String oldPassword,
    required String newPassword,
  });
}
