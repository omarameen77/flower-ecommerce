import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:flower/core/network/dio_helper.dart';
import 'package:flower/features/auth/api/auth_api.dart';

@module
abstract class NetworkModule {

  @lazySingleton
  Dio get dio => DioHelper.dio;

  @lazySingleton
  AuthApi authApi(Dio dio) => AuthApi(dio);
}
