import 'package:dio/dio.dart';
import 'package:flower/core/error/error_massage.dart';

class Failure {
  final String message;

  Failure({required this.message});
}

class ErrorHandler {
  static Failure handle(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
          return Failure(message: ErrorMassage.connectionTimeout);

        case DioExceptionType.sendTimeout:
          return Failure(message: ErrorMassage.sendTimeout);

        case DioExceptionType.receiveTimeout:
          return Failure(message: ErrorMassage.receiveTimeout);

        case DioExceptionType.badResponse:
          return Failure(
            message: error.response?.data["error"] ?? ErrorMassage.serverError,
          );

        case DioExceptionType.connectionError:
          return Failure(message: ErrorMassage.noInternet);

        default:
          return Failure(message: ErrorMassage.unexpectedError);
      }
    }

    return Failure(message: ErrorMassage.unknownError);
  }
}
