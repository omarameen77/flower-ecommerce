part of 'verify_reset_code_cubit.dart';

class VerifyResetCodeState extends Equatable {
  final BaseState<VerifyResetCodeEntity> base;
  final bool hasError;
  final bool isResending;
  final bool resendSucceeded;
  final String? resendErrorMessage;

  const VerifyResetCodeState({
    this.base = const BaseState(),
    this.hasError = false,
    this.isResending = false,
    this.resendSucceeded = false,
    this.resendErrorMessage,
  });

  VerifyResetCodeState copyWith({
    BaseState<VerifyResetCodeEntity>? base,
    bool? hasError,
    bool? isResending,
    bool? resendSucceeded,
    String? resendErrorMessage,
  }) {
    return VerifyResetCodeState(
      base: base ?? this.base,
      hasError: hasError ?? this.hasError,
      isResending: isResending ?? this.isResending,
      resendSucceeded: resendSucceeded ?? this.resendSucceeded,
      resendErrorMessage: resendErrorMessage ?? this.resendErrorMessage,
    );
  }

  @override
  List<Object?> get props => [
    base,
    hasError,
    isResending,
    resendSucceeded,
    resendErrorMessage,
  ];
}
