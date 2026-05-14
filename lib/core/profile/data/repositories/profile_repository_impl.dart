import 'package:flower/config/base/base_response.dart';
import 'package:flower/core/network/model/user_models/user_entity.dart';
import 'package:flower/core/profile/data/datasources/profile_remote_data_source.dart';
import 'package:flower/core/profile/domain/repositories/profile_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ProfileRepository)
class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource _remoteDataSource;

  ProfileRepositoryImpl(this._remoteDataSource);

  @override
  Future<BaseResponse<UserEntity>> getProfile() async {
    final response = await _remoteDataSource.getProfile();
    if (response is SuccessBaseResponse) {
      final userDto = (response as SuccessBaseResponse).data;
      return SuccessBaseResponse<UserEntity>(data: userDto.toDomain());
    } else {
      return ErrorBaseResponse<UserEntity>(
        failure: (response as ErrorBaseResponse).failure,
      );
    }
  }
}
