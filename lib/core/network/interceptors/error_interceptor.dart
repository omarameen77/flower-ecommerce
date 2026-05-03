import 'package:dio/dio.dart';
import '../../storage/secure_storage_service.dart';

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final statusCode = err.response?.statusCode;

    if (statusCode == 401) {
      await SecureStorageService.deleteToken();

      //*   logout redirect او Bloc event
    }

    handler.next(err);
  }
}
