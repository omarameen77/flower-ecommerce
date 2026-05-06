import 'package:dio/dio.dart';
import 'package:flower/core/network/dio_helper.dart';
import 'package:flower/features/auth/api/auth_api.dart';
import 'package:injectable/injectable.dart';

@module
abstract class NetworkModule {
  @singleton
  Dio get dio => DioHelper.dio;

  @singleton
  AuthApi authApi(Dio dio) => AuthApi(dio);
}
