import 'package:flower/core/error/error_handler.dart';

sealed class BaseResponse<T> {}

class SuccessBaseResponse<T> extends BaseResponse<T> {
  final T data;

  SuccessBaseResponse({required this.data});
}

class ErrorBaseResponse<T> extends BaseResponse<T> {
  final Failure failure;

  ErrorBaseResponse({required this.failure});
}
