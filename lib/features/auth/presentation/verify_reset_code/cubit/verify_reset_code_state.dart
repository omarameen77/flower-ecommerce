part of 'verify_reset_code_cubit.dart';

class VerifyResetCodeState extends BaseState<VerifyResetCodeEntity> {
  final bool hasError;
  final bool isResending;
  final bool resendSucceeded;
  final String? resendErrorMessage;

  const VerifyResetCodeState({
    super.isLoading,
    super.data,
    super.errorMessage,
    this.hasError = false,
    this.isResending = false,
    this.resendSucceeded = false,
    this.resendErrorMessage,
  });

  factory VerifyResetCodeState.initial() => const VerifyResetCodeState();

  @override
  VerifyResetCodeState copyWith({
    bool? isLoadingParam,
    VerifyResetCodeEntity? dataParam,
    String? errorMessageParam,
    bool? hasError,
    bool? isResending,
    bool? resendSucceeded,
    String? resendErrorMessage,
  }) {
    return VerifyResetCodeState(
      isLoading: isLoadingParam ?? isLoading,
      data: dataParam ?? data,
      errorMessage: errorMessageParam,
      hasError: hasError ?? this.hasError,
      isResending: isResending ?? this.isResending,
      resendSucceeded: resendSucceeded ?? this.resendSucceeded,
      resendErrorMessage: resendErrorMessage ?? this.resendErrorMessage,
    );
  }

  @override
  List<Object?> get props => [
    ...super.props,
    hasError,
    isResending,
    resendSucceeded,
    resendErrorMessage,
  ];
}
