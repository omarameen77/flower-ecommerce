part of 'forget_password_cubit.dart';

class ForgetPasswordState extends BaseState<ForgetPasswordEntity> {
  const ForgetPasswordState({
    super.isLoading,
    super.data,
    super.errorMessage,
  });

  factory ForgetPasswordState.initial() => const ForgetPasswordState();

  @override
  ForgetPasswordState copyWith({
    bool? isLoadingParam,
    ForgetPasswordEntity? dataParam,
    String? errorMessageParam,
  }) {
    return ForgetPasswordState(
      isLoading: isLoadingParam ?? isLoading,
      data: dataParam ?? data,
      errorMessage: errorMessageParam,
    );
  }
}
