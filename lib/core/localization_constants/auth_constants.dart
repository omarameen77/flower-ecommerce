import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

extension AuthConstants on BuildContext {
  // ───────── General ─────────
  String get login => "auth.login".tr();
  String get signUp => "auth.sign_up".tr();
  String get email => "auth.email".tr();
  String get password => "auth.password".tr();
  String get confirmPassword => "auth.confirm_password".tr();
  String get firstName => "auth.first_name".tr();
  String get lastName => "auth.last_name".tr();
  String get phone => "auth.phone".tr();
  String get rememberMe => "auth.remember_me".tr();
  String get forgotPassword => "auth.forgot_password".tr();
  String get dontHaveAccount => "auth.dont_have_account".tr();
  String get alreadyHaveAccount => "auth.already_have_account".tr();
  String get continueAsGuest => "auth.continue_as_guest".tr();
  String get confirm => "auth.confirm".tr();
  String get resend => "auth.resend".tr();

  // ───────── Gender ─────────
  String get gender => "auth.gender".tr();
  String get female => "auth.female".tr();
  String get male => "auth.male".tr();

  // ───────── Placeholders ─────────
  String get enterEmail => "auth.enter_email".tr();
  String get enterPassword => "auth.enter_password".tr();
  String get enterFirstName => "auth.enter_first_name".tr();
  String get enterLastName => "auth.enter_last_name".tr();
  String get enterPhoneNumber => "auth.enter_phone_number".tr();
  String get enterNewPassword => "auth.enter_new_password".tr();

  // ───────── Errors ─────────
  String get invalidEmail => "auth.invalid_email".tr();
  String get invalidPassword => "auth.invalid_password".tr();
  String get invalidCode => "auth.invalid_code".tr();

  // ───────── Forget Password ─────────
  String get forgetPasswordTitle => "auth.forget_password_title".tr();
  String get forgetPasswordSubtitle => "auth.forget_password_subtitle".tr();

  // ───────── Verification ─────────
  String get emailVerification => "auth.email_verification".tr();
  String get verificationCodeSubtitle => "auth.verification_code_subtitle".tr();
  String get didntReceiveCode => "auth.didnt_receive_code".tr();
  String get codeSentAgain => "auth.code_sent_again".tr();

  // ───────── Reset Password ─────────
  String get resetPassword => "auth.reset_password".tr();
  String get resetPasswordCondition => "auth.reset_password_condition".tr();
  String get newPassword => "auth.new_password".tr();

  // ───────── Terms ─────────
  String get termsAndConditionsStatement =>
      "auth.terms_and_conditions_statement".tr();

  // ───────── Validation ─────────

  String get requiredField => "validation.required".tr();

  //  Email
  String get emailRequired => "validation.email_required".tr();
  String get invalidEmailVal => "validation.invalid_email".tr();

  //  Password
  String get passwordRequired => "validation.password_required".tr();
  String get shortPassword => "validation.short_password".tr();
  String get weakPassword => "validation.weak_password".tr();

  //  Confirm Password
  String get confirmPasswordRequired =>
      "validation.confirm_password_required".tr();

  String get passwordNotMatch => "validation.password_not_match".tr();

  //  Name
  String get nameRequired => "validation.name_required".tr();
  String get invalidName => "validation.invalid_name".tr();
  String get shortName => "validation.short_name".tr();

  //  Phone
  String get phoneRequired => "validation.phone_required".tr();
  String get invalidPhone => "validation.invalid_phone".tr();

  //  OTP / Code
  String get codeRequired => "validation.code_required".tr();
  String get invalidCodeVal => "validation.invalid_code".tr();
}
