import 'package:dio/dio.dart';
import 'package:flower/core/network/endpoints.dart';
import 'package:flower/features/auth/data/models/request/login_request.dart';
import 'package:flower/features/auth/data/models/request/register_request.dart';
import 'package:flower/features/auth/data/models/response/login_response.dart';
import 'package:flower/features/auth/data/models/response/register_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_api.g.dart';

@injectable
@RestApi()
abstract class AuthApi {
  factory AuthApi(Dio dio, {String baseUrl}) = _AuthApi;

  @POST(AuthEndPoint.signIn)
  Future<LoginResponseDto> login(@Body() LoginRequestDto request);

  @POST(AuthEndPoint.signUp)
  Future<RegisterResponseDto> register(@Body() RegisterRequestDto request);

  // implement other function
}
