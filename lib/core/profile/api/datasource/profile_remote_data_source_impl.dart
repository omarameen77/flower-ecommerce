import 'package:flower/config/base/base_response.dart';
import 'package:flower/core/error/error_handler.dart';
import 'package:flower/core/network/model/user_models/user.dart';
import 'package:flower/core/profile/api/api_client/profile_api_client.dart';
import 'package:flower/core/profile/data/datasources/profile_remote_data_source.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ProfileRemoteDataSource)
class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final ProfileApiClient _profileApiClient;

  ProfileRemoteDataSourceImpl(this._profileApiClient);

  @override
  Future<BaseResponse<UserDto>> getProfile() async {
    try {
      final response = await _profileApiClient.getProfile();
      if (response.user != null) {
        return SuccessBaseResponse<UserDto>(data: response.user!);
      } else {
        return ErrorBaseResponse<UserDto>(
          failure: ErrorHandler.handle("user not found!!!"),
        );
      }
    } catch (e) {
      return ErrorBaseResponse<UserDto>(failure: ErrorHandler.handle(e));
    }
  }
}
