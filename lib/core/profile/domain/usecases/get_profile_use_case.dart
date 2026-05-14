import 'package:flower/config/base/base_response.dart';
import 'package:flower/core/network/model/user_models/user_entity.dart';
import 'package:flower/core/profile/domain/repositories/profile_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetProfileUseCase {
  final ProfileRepository _repository;

  GetProfileUseCase(this._repository);

  Future<BaseResponse<UserEntity>> call() {
    return _repository.getProfile();
  }
}
