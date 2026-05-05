import 'package:dio/dio.dart';
import 'package:flower/core/network/endpoints.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'interceptors/auth_interceptor.dart';

class DioHelper {
  static late Dio dio;

  static void init() {
    dio = Dio(
      BaseOptions(
        baseUrl: AuthEndPoint.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        responseType: ResponseType.json,
        headers: {"Content-Type": "application/json"},
        validateStatus: (status) {
          return status != null && status < 400;
        },
      ),
    );

    dio.interceptors
      ..add(AuthInterceptor())
      ..add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          error: true,
          compact: true,
        ),
      );
  }
}
