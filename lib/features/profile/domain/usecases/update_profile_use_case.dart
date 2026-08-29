import 'package:flower/config/base/base_response.dart';
import 'package:flower/core/network/model/user_entity.dart';
import 'package:flower/features/profile/domain/repositories/profile_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdateProfileUseCase {
  final ProfileRepository _repository;

  UpdateProfileUseCase(this._repository);

  Future<BaseResponse<UserEntity>> call({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
  }) {
    return _repository.editProfile(
      firstName: firstName,
      lastName: lastName,
      email: email,
      phone: phone,
    );
  }
}
