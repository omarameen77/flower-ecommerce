import 'package:dio/dio.dart';
import 'package:flower/core/network/dio_helper.dart';
import 'package:flower/features/auth/api/auth_api.dart';
import 'package:injectable/injectable.dart';

@module
abstract class RegisterModule {
  @lazySingleton
  Dio get dio => DioHelper.dio;

  @lazySingleton
  AuthApi authApi(Dio dio) => AuthApi(dio);
}
