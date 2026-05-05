import 'package:flower/config/base/base_response.dart';
import 'package:flower/features/auth/domain/models/forget_password_entity.dart';
import 'package:flower/features/auth/domain/repos/auth_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class ForgetPasswordUseCase {
  final AuthRepo _repo;

  ForgetPasswordUseCase(this._repo);

  Future<BaseResponse<ForgetPasswordEntity>> call({required String email}) {
    return _repo.forgetPassword(email: email);
  }
}
