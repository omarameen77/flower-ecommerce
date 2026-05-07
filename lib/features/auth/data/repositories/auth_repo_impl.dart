import 'package:flower/config/base/base_response.dart';
import 'package:flower/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:flower/features/auth/domain/entities/forget_password_entity.dart';
import 'package:flower/features/auth/domain/entities/reset_password_entity.dart';
import 'package:flower/features/auth/domain/entities/verify_reset_code_entity.dart';
import 'package:flower/features/auth/domain/repositories/auth_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRepo)
class AuthRepoImpl implements AuthRepo {
  final AuthRemoteDs _remoteDs;

  AuthRepoImpl(this._remoteDs);

  @override
  Future<BaseResponse<ForgetPasswordEntity>> forgetPassword({
    required String email,
  }) async {
    final response = await _remoteDs.forgetPassword(email: email);
    return switch (response) {
      SuccessBaseResponse() =>
        SuccessBaseResponse(data: response.data.toEntity()),
      ErrorBaseResponse() => ErrorBaseResponse(failure: response.failure),
    };
  }

  @override
  Future<BaseResponse<VerifyResetCodeEntity>> verifyResetCode({
    required String resetCode,
  }) async {
    final response = await _remoteDs.verifyResetCode(resetCode: resetCode);
    return switch (response) {
      SuccessBaseResponse() =>
        SuccessBaseResponse(data: response.data.toEntity()),
      ErrorBaseResponse() => ErrorBaseResponse(failure: response.failure),
    };
  }

  @override
  Future<BaseResponse<ResetPasswordEntity>> resetPassword({
    required String email,
    required String newPassword,
  }) async {
    final response = await _remoteDs.resetPassword(
      email: email,
      newPassword: newPassword,
    );
    return switch (response) {
      SuccessBaseResponse() =>
        SuccessBaseResponse(data: response.data.toEntity()),
      ErrorBaseResponse() => ErrorBaseResponse(failure: response.failure),
    };
  }
}
