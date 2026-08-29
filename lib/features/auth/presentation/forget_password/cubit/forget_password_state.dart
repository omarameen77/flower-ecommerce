part of 'forget_password_cubit.dart';

class ForgetPasswordState extends Equatable {
  final BaseState<ForgetPasswordEntity> base;
  final String email;

  final bool isVerifyingCode;
  final bool? isCodeValid;
  final String? codeErrorMessage;

  final bool codeVerified;

  const ForgetPasswordState({
    this.base = const BaseState(),
    this.email = '',
    this.isVerifyingCode = false,
    this.isCodeValid,
    this.codeErrorMessage,
    this.codeVerified = false,
  });

  ForgetPasswordState copyWith({
    BaseState<ForgetPasswordEntity>? base,
    String? email,
    bool? isVerifyingCode,
    bool? isCodeValid,
    String? codeErrorMessage,
    bool clearCodeError = false,
    bool? codeVerified,
    bool clearCodeValidation = false,
  }) {
    return ForgetPasswordState(
      base: base ?? this.base,
      email: email ?? this.email,
      isVerifyingCode: isVerifyingCode ?? this.isVerifyingCode,
      isCodeValid: clearCodeValidation ? null : isCodeValid ?? this.isCodeValid,
      codeErrorMessage: clearCodeError
          ? null
          : codeErrorMessage ?? this.codeErrorMessage,
      codeVerified: codeVerified ?? this.codeVerified,
    );
  }

  @override
  List<Object?> get props => [
    base,
    email,
    isVerifyingCode,
    isCodeValid,
    codeErrorMessage,
    codeVerified,
  ];
}
