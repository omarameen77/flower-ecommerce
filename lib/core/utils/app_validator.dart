import 'package:flower/core/localization_constants/auth_constants.dart';
import 'package:flutter/material.dart';

class AppValidation {
  static bool isEmpty(String? v) => v == null || v.trim().isEmpty;

  static String value(String? v) => v?.trim() ?? '';
}

class AppValidator {
  //  Email
  static String? email(BuildContext context, String? value) {
    final v = AppValidation.value(value);

    if (v.isEmpty) return context.emailRequired;

    final regex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]+$');

    if (!regex.hasMatch(v)) {
      return context.invalidEmail;
    }

    return null;
  }

  //  Password (Strong)
  static String? password(BuildContext context, String? value) {
    final v = AppValidation.value(value);

    if (v.isEmpty) return context.passwordRequired;

    if (v.length < 8) return context.shortPassword;

    final hasUpper = RegExp(r'[A-Z]').hasMatch(v);
    final hasLower = RegExp(r'[a-z]').hasMatch(v);
    final hasNumber = RegExp(r'[0-9]').hasMatch(v);
    final hasSpecial = RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(v);

    if (!hasUpper || !hasLower || !hasNumber || !hasSpecial) {
      return "Password must include uppercase, lowercase, number & special character";
    }

    return null;
  }

  //  Name
  static String? name(BuildContext context, String? value) {
    final v = AppValidation.value(value);

    if (v.isEmpty) return context.nameRequired;

    if (v.length < 3) return "Name too short";

    final regex = RegExp(r"^[a-zA-Z\s]+$");

    if (!regex.hasMatch(v)) {
      return "Name must contain letters only";
    }

    return null;
  }

  //  Egyptian Phone
  static String? phone(BuildContext context, String? value) {
    final v = value?.trim() ?? '';

    if (v.isEmpty) {
      return context.phoneRequired;
    }

    final regex = RegExp(r'^\+\d{10,15}$');

    if (!regex.hasMatch(v)) {
      return context.phoneFormatHint;
    }

    return null;
  }

  //  Confirm Password
  static String? confirmPassword(
    BuildContext context,
    String? value,
    String original,
  ) {
    final v = AppValidation.value(value);

    if (v.isEmpty) return context.confirmPasswordRequired;

    if (v != original) return context.passwordNotMatch;

    return null;
  }

  //  OTP Code (6 digits fixed)
  static String? code(BuildContext context, String? value) {
    final v = AppValidation.value(value);

    if (v.isEmpty) return context.codeRequired;

    final regex = RegExp(r'^\d{6}$');

    if (!regex.hasMatch(v)) {
      return context.invalidCode;
    }

    return null;
  }
}
