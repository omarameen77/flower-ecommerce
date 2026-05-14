import 'package:flower/config/base/base_response.dart';
import 'package:flower/core/network/model/user.dart';
import 'package:flower/core/network/model/user_entity.dart';
import 'package:flower/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:flower/features/auth/domain/entities/change_password_entity.dart';
import 'package:flower/features/auth/domain/entities/forget_password_entity.dart';
import 'package:flower/features/auth/domain/entities/reset_password_entity.dart';
import 'package:flower/features/auth/domain/entities/verify_reset_code_entity.dart';
import 'package:flower/features/auth/domain/repositories/auth_repo.dart';
import 'package:flower/features/auth/domain/use_cases/login_params.dart';
import 'package:flower/features/auth/domain/use_cases/register_params.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRepo)
class AuthRepoImpl implements AuthRepo {
  final AuthRemoteDataSourceContract authRemoteDataSourceContract;

  AuthRepoImpl({required this.authRemoteDataSourceContract});
  @override
  Future<BaseResponse<UserEntity>> login(LoginParams params) async {
    final response = await authRemoteDataSourceContract.login(params);

    switch (response) {
      case SuccessBaseResponse<UserDto>():
        return SuccessBaseResponse<UserEntity>(data: response.data.toDomain());

      case ErrorBaseResponse<UserDto>():
        return ErrorBaseResponse<UserEntity>(failure: response.failure);
    }
  }

  @override
  Future<BaseResponse<UserEntity>> register(RegisterParams params) async {
    final response = await authRemoteDataSourceContract.register(params);
    switch (response) {
      case SuccessBaseResponse<UserDto>():
        return SuccessBaseResponse<UserEntity>(data: response.data.toDomain());
      case ErrorBaseResponse<UserDto>():
        return ErrorBaseResponse<UserEntity>(failure: response.failure);
    }
  }

  @override
  Future<BaseResponse<ForgetPasswordEntity>> forgetPassword({
    required String email,
  }) async {
    final response = await authRemoteDataSourceContract.forgetPassword(
      email: email,
    );
    return switch (response) {
      SuccessBaseResponse() => SuccessBaseResponse(
        data: response.data.toEntity(),
      ),
      ErrorBaseResponse() => ErrorBaseResponse(failure: response.failure),
    };
  }

  @override
  Future<BaseResponse<VerifyResetCodeEntity>> verifyResetCode({
    required String resetCode,
  }) async {
    final response = await authRemoteDataSourceContract.verifyResetCode(
      resetCode: resetCode,
    );
    return switch (response) {
      SuccessBaseResponse() => SuccessBaseResponse(
        data: response.data.toEntity(),
      ),
      ErrorBaseResponse() => ErrorBaseResponse(failure: response.failure),
    };
  }

  @override
  Future<BaseResponse<ResetPasswordEntity>> resetPassword({
    required String email,
    required String newPassword,
  }) async {
    final response = await authRemoteDataSourceContract.resetPassword(
      email: email,
      newPassword: newPassword,
    );
    return switch (response) {
      SuccessBaseResponse() => SuccessBaseResponse(
        data: response.data.toEntity(),
      ),
      ErrorBaseResponse() => ErrorBaseResponse(failure: response.failure),
    };
  }

  @override
  Future<BaseResponse<ChangePasswordEntity>> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    final response = await authRemoteDataSourceContract.changePassword(
      oldPassword: oldPassword,
      newPassword: newPassword,
    );
    return switch (response) {
      SuccessBaseResponse() => SuccessBaseResponse(
        data: response.data.toEntity(),
      ),
      ErrorBaseResponse() => ErrorBaseResponse(failure: response.failure),
    };
  }
}
