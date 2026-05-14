import 'package:flower/config/base/base_response.dart';
import 'package:flower/core/error/error_handler.dart';
import 'package:flower/core/network/model/user_models/user.dart';
import 'package:flower/features/edit_profile/api/api_client/edit_profile_api_client.dart';
import 'package:flower/features/edit_profile/data/datasources/edit_profile_remote_data_source.dart';
import 'package:flower/features/edit_profile/data/models/edit_profile_request.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: EditProfileRemoteDataSource)
class EditProfileRemoteDataSourceImpl implements EditProfileRemoteDataSource {
  final EditProfileApiClient _apiClient;

  EditProfileRemoteDataSourceImpl(this._apiClient);

  @override
  Future<BaseResponse<UserDto>> editProfile(EditProfileRequestDto request) async {
    try {
      final response = await _apiClient.editProfile(request);
      if (response.user != null) {
        return SuccessBaseResponse<UserDto>(data: response.user!);
      }
      return ErrorBaseResponse<UserDto>(
        failure: ErrorHandler.handle(response.message ?? 'user not found'),
      );
    } catch (e) {
      return ErrorBaseResponse<UserDto>(failure: ErrorHandler.handle(e));
    }
  }
}
