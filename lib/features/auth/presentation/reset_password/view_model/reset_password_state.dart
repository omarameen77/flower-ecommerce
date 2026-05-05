import 'package:flower/config/base/base_state.dart';
import 'package:flower/features/auth/domain/models/reset_password_entity.dart';

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

  ResetPasswordState toLoading() => ResetPasswordState(
    isLoading: true,
    isObscurePassword: isObscurePassword,
    isObscureConfirm: isObscureConfirm,
  );

  ResetPasswordState toSuccess(ResetPasswordEntity data) => ResetPasswordState(
    data: data,
    isObscurePassword: isObscurePassword,
    isObscureConfirm: isObscureConfirm,
  );

  ResetPasswordState toError(String message) => ResetPasswordState(
    errorMessage: message,
    isObscurePassword: isObscurePassword,
    isObscureConfirm: isObscureConfirm,
  );

  ResetPasswordState togglePassword() => ResetPasswordState(
    isLoading: isLoading,
    data: data,
    errorMessage: errorMessage,
    isObscurePassword: !isObscurePassword,
    isObscureConfirm: isObscureConfirm,
  );

  ResetPasswordState toggleConfirm() => ResetPasswordState(
    isLoading: isLoading,
    data: data,
    errorMessage: errorMessage,
    isObscurePassword: isObscurePassword,
    isObscureConfirm: !isObscureConfirm,
  );

  @override
  List<Object?> get props => [...super.props, isObscurePassword, isObscureConfirm];
}
