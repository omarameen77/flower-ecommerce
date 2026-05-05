import 'package:flower/config/base/base_response.dart';
import 'package:flower/features/auth/domain/models/reset_password_entity.dart';
import 'package:flower/features/auth/domain/repos/auth_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class ResetPasswordUseCase {
  final AuthRepo _repo;

  ResetPasswordUseCase(this._repo);

  Future<BaseResponse<ResetPasswordEntity>> call({
    required String email,
    required String newPassword,
  }) {
    return _repo.resetPassword(email: email, newPassword: newPassword);
  }
}
