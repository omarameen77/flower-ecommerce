import 'package:dio/dio.dart';
import 'package:flower/core/localization_constants/error_massage_constants.dart';

class Failure {
  final String message;

  Failure({required this.message});
}

class ErrorHandler {
  static Failure handle(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
          return Failure(message: ErrorConstants.connectionTimeout);

        case DioExceptionType.sendTimeout:
          return Failure(message: ErrorConstants.sendTimeout);

        case DioExceptionType.receiveTimeout:
          return Failure(message: ErrorConstants.receiveTimeout);

        case DioExceptionType.badResponse:
          final data = error.response?.data;

          if (data is Map<String, dynamic>) {
            return Failure(
              message:
                  data["message"] ??
                  data["error"]?.toString() ??
                  ErrorConstants.serverError,
            );
          }

        case DioExceptionType.connectionError:
          return Failure(message: ErrorConstants.noInternet);

        default:
          return Failure(message: ErrorConstants.unexpectedError);
      }
    }

    return Failure(message: ErrorConstants.unknownError);
  }
}
