part of 'reset_password_cubit.dart';

class ResetPasswordState extends BaseState<ResetPasswordEntity> {
  final bool isObscurePassword;
  final bool isObscureConfirm;

  const ResetPasswordState({
    super.isLoading,
    super.data,
    super.errorMessage,
    this.isObscurePassword = true,
    this.isObscureConfirm = true,
  });

  factory ResetPasswordState.initial() => const ResetPasswordState();

  @override
  ResetPasswordState copyWith({
    bool? isLoadingParam,
    ResetPasswordEntity? dataParam,
    String? errorMessageParam,
    bool? isObscurePassword,
    bool? isObscureConfirm,
  }) {
    return ResetPasswordState(
      isLoading: isLoadingParam ?? isLoading,
      data: dataParam ?? data,
      errorMessage: errorMessageParam,
      isObscurePassword: isObscurePassword ?? this.isObscurePassword,
      isObscureConfirm: isObscureConfirm ?? this.isObscureConfirm,
    );
  }

  @override
  List<Object?> get props => [
    ...super.props,
    isObscurePassword,
    isObscureConfirm,
  ];
}
