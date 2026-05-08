import 'package:flower/config/base/base_response.dart';
import 'package:flower/features/auth/login/domain/entity/login_request.dart';
import 'package:flower/features/auth/login/domain/repo/login_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginUseCase {
  final LoginRepoContract repo;

  LoginUseCase(this.repo);

  Future<BaseResponse> execute(LoginRequest request) {
    return repo.login(request);
  }
}