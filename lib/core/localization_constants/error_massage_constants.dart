import 'package:easy_localization/easy_localization.dart';

abstract class ErrorConstants {
  const ErrorConstants._();

  static String get noInternet => "error_massages.noInternet".tr();
  static String get connectionTimeout =>
      "error_massages.connectionTimeout".tr();
  static String get sendTimeout => "error_massages.sendTimeout".tr();
  static String get receiveTimeout => "error_massages.receiveTimeout".tr();
  static String get serverError => "error_massages.serverError".tr();
  static String get unexpectedError => "error_massages.unexpectedError".tr();
  static String get unknownError => "error_massages.unknownError".tr();
  static String get loginSuccessfully =>
      "error_massages.login_successfully".tr();
  static String get signupSuccessfully =>
      "error_massages.signup_successfully".tr();
}
