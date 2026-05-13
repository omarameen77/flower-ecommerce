import 'package:flower/config/base/base_response.dart';
import 'package:flower/core/error/error_handler.dart';
import 'package:injectable/injectable.dart';

@injectable
class SafeApiCaller {
  Future<BaseResponse<T>> safeCall<T>(Future<T> Function() call) async {
    try {
      final response = await call();
      return SuccessBaseResponse<T>(data: response);
    } catch (error) {
      final failure = ErrorHandler.handle(error);
      return ErrorBaseResponse<T>(failure: failure);
    }
  }
}
