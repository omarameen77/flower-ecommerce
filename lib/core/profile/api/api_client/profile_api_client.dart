import 'package:dio/dio.dart';
import 'package:flower/core/network/endpoints.dart';
import 'package:flower/core/network/model/profile_response/profile_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'profile_api_client.g.dart';

@RestApi()
abstract class ProfileApiClient {
  @factoryMethod
  factory ProfileApiClient(Dio dio, {String baseUrl}) = _ProfileApiClient;

  @GET(AuthEndPoint.profile)
  Future<ProfileResponseDto> getProfile();
}