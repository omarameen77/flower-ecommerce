import 'package:flower/config/base/base_response.dart';
import 'package:flower/core/network/model/user_entity.dart';
import 'package:flower/features/auth/domain/repositories/auth_repo.dart';
import 'package:flower/features/auth/domain/usecases/register_params.dart';
import 'package:injectable/injectable.dart';

@injectable
class RegisterUseCase {
  final AuthRepo registerRepoContract;

  RegisterUseCase({required this.registerRepoContract});

  Future<BaseResponse<UserEntity>> call(RegisterParams params) async {
    return registerRepoContract.register(params);
  }
}
