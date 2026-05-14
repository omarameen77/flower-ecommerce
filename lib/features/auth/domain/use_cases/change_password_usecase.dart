import 'package:flower/config/base/base_response.dart';
import 'package:flower/features/auth/domain/entities/change_password_entity.dart';
import 'package:flower/features/auth/domain/repositories/auth_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class ChangePasswordUseCase {
  final AuthRepo _repo;

  ChangePasswordUseCase(this._repo);

  Future<BaseResponse<ChangePasswordEntity>> call({
    required String oldPassword,
    required String newPassword,
  }) {
    return _repo.changePassword(
      oldPassword: oldPassword,
      newPassword: newPassword,
    );
  }
}
