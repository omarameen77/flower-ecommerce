import 'package:flower/config/base/base_response.dart';
import 'package:flower/core/network/model/user.dart';
import 'package:flower/core/network/model/user_entity.dart';
import 'package:flower/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:flower/features/auth/domain/repositories/auth_repo.dart';
import 'package:flower/features/auth/domain/use_cases/register_params.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRepo)
class AuthRepoImpl implements AuthRepo {
  final AuthRemoteDataSourceContract authRemoteDataSourceContract;

  AuthRepoImpl({required this.authRemoteDataSourceContract});

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
}
