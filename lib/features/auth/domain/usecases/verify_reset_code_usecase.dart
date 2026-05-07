import 'package:flower/config/base/base_response.dart';
import 'package:flower/features/auth/domain/entities/verify_reset_code_entity.dart';
import 'package:flower/features/auth/domain/repositories/auth_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class VerifyResetCodeUseCase {
  final AuthRepo _repo;

  VerifyResetCodeUseCase(this._repo);

  Future<BaseResponse<VerifyResetCodeEntity>> call({
    required String resetCode,
  }) {
    return _repo.verifyResetCode(resetCode: resetCode);
  }
}
