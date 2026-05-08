import 'package:dio/dio.dart';
import 'package:flower/core/network/endpoints.dart';
import 'package:flower/features/auth/data/models/request/register_request.dart';
import 'package:flower/features/auth/data/models/response/register_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
part 'auth_api_client.g.dart';

@RestApi()
abstract class AuthApiClient {
  @factoryMethod
  factory AuthApiClient(Dio dio, {String baseUrl}) = _AuthApiClient;

  @POST(AuthEndPoint.signUp)
  Future<RegisterResponseDto> register(@Body() RegisterRequestDto request);
}
