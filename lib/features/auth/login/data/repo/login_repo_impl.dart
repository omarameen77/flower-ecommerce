

import 'package:flower/config/base/base_response.dart';
import 'package:flower/features/auth/login/data/data_source/login_remote_datasource.dart';
import 'package:flower/features/auth/login/domain/entity/login_request.dart';
import 'package:flower/features/auth/login/domain/entity/login_response.dart';
import 'package:flower/features/auth/login/domain/repo/login_repo_contract.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: LoginRepoContract)
class LoginRepoImpl implements LoginRepoContract {
  final LoginRemoteDataSourceContract remoteDataSource;

  LoginRepoImpl({required this.remoteDataSource});

  @override
  Future<BaseResponse<LoginResponse>> login(LoginRequest loginRequest) {
    return remoteDataSource.login(loginRequest.toDTO());
  }
}
