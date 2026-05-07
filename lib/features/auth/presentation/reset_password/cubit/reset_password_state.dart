part of 'reset_password_cubit.dart';

class ResetPasswordState extends BaseState<ResetPasswordEntity> {
  const ResetPasswordState({
    super.isLoading,
    super.data,
    super.errorMessage,
  });

  factory ResetPasswordState.initial() => const ResetPasswordState();

  @override
  ResetPasswordState copyWith({
    bool? isLoadingParam,
    ResetPasswordEntity? dataParam,
    String? errorMessageParam,
  }) {
    return ResetPasswordState(
      isLoading: isLoadingParam ?? isLoading,
      data: dataParam ?? data,
      errorMessage: errorMessageParam,
    );
  }
}
