import 'package:flower/core/localization_constants/validation_constants.dart';

class AppValidation {
  AppValidation._();

  static String value(String? v) => v?.trim() ?? '';
}

class AppValidator {
  AppValidator._();
  // Email
  static String? email(String? value) {
    final v = AppValidation.value(value);

    if (v.isEmpty) return ValidationConstants.emailRequired;

    final regex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]+$');

    if (!regex.hasMatch(v)) {
      return ValidationConstants.invalidEmail;
    }

    return null;
  }

  // Password (Strong)
  static String? password(String? value) {
    final v = AppValidation.value(value);

    if (v.isEmpty) return ValidationConstants.passwordRequired;

    if (v.length < 8) return ValidationConstants.shortPassword;

    final hasUpper = RegExp(r'[A-Z]').hasMatch(v);
    final hasLower = RegExp(r'[a-z]').hasMatch(v);
    final hasNumber = RegExp(r'[0-9]').hasMatch(v);
    final hasSpecial = RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(v);

    if (!hasUpper || !hasLower || !hasNumber || !hasSpecial) {
      return ValidationConstants.weakPassword;
    }

    return null;
  }

  // Name (English + Arabic)
  static String? name(String? value) {
    final v = AppValidation.value(value);

    if (v.isEmpty) return ValidationConstants.nameRequired;

    if (v.length < 3) return ValidationConstants.shortName;

    final regex = RegExp(r"^[a-zA-Z\u0600-\u06FF\s]+$");

    if (!regex.hasMatch(v)) {
      return ValidationConstants.invalidName;
    }

    return null;
  }

  // Egyptian Phone
  static String? phone(String? value) {
    final v = AppValidation.value(value);

    if (v.isEmpty) {
      return ValidationConstants.phoneRequired;
    }

    final regex = RegExp(r'^\+\d{10,15}$');

    if (!regex.hasMatch(v)) {
      return ValidationConstants.phoneFormatHint;
    }

    return null;
  }

  // Confirm Password
  static String? confirmPassword(String? value, String original) {
    final v = AppValidation.value(value);

    if (v.isEmpty) return ValidationConstants.confirmPasswordRequired;

    if (v != original) return ValidationConstants.passwordNotMatch;

    return null;
  }

  // OTP Code (6 digits fixed)
  static String? code(String? value) {
    final v = AppValidation.value(value);

    if (v.isEmpty) return ValidationConstants.codeRequired;

    final regex = RegExp(r'^\d{6}$');

    if (!regex.hasMatch(v)) {
      return ValidationConstants.invalidCode;
    }

    return null;
  }
}
