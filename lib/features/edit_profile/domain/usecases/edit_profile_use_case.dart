import 'package:flower/config/base/base_response.dart';
import 'package:flower/core/network/model/user_models/user_entity.dart';
import 'package:flower/features/edit_profile/domain/repositories/edit_profile_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class EditProfileUseCase {
  final EditProfileRepository _repository;

  EditProfileUseCase(this._repository);

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
