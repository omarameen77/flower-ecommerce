import 'package:flower/config/base/base_state.dart';
import 'package:flower/features/auth/domain/models/verify_reset_code_entity.dart';

class VerifyResetCodeState extends BaseState<VerifyResetCodeEntity> {
  final bool hasError;

  const VerifyResetCodeState({
    super.isLoading,
    super.data,
    super.errorMessage,
    this.hasError = false,
  });

  factory VerifyResetCodeState.initial() => const VerifyResetCodeState();

  factory VerifyResetCodeState.loading() =>
      const VerifyResetCodeState(isLoading: true);

  factory VerifyResetCodeState.success(VerifyResetCodeEntity data) =>
      VerifyResetCodeState(data: data);

  factory VerifyResetCodeState.error(String message) =>
      VerifyResetCodeState(errorMessage: message, hasError: true);

  @override
  List<Object?> get props => [...super.props, hasError];
}
