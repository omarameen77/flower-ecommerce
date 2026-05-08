import 'package:easy_localization/easy_localization.dart';

abstract class ValidationConstants {
  ValidationConstants._();

  // Email
  static String get emailRequired => "validation.email_required".tr();

  static String get invalidEmail => "validation.invalid_email".tr();

  // Password
  static String get passwordRequired => "validation.password_required".tr();

  static String get shortPassword => "validation.short_password".tr();

  static String get weakPassword => "validation.weak_password".tr();

  // Name
  static String get nameRequired => "validation.name_required".tr();

  static String get shortName => "validation.short_name".tr();

  static String get invalidName => "validation.invalid_name".tr();

  // Phone
  static String get phoneRequired => "validation.phone_required".tr();

  static String get phoneFormatHint => "validation.phone_format_hint".tr();

  // Confirm Password
  static String get confirmPasswordRequired =>
      "validation.confirm_password_required".tr();

  static String get passwordNotMatch => "validation.password_not_match".tr();

  // Code
  static String get codeRequired => "validation.code_required".tr();

  static String get invalidCode => "validation.invalid_code".tr();
}
