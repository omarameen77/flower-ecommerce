import 'package:flower/config/base/base_state.dart';
import 'package:flower/features/auth/domain/models/forget_password_entity.dart';

class ForgetPasswordState extends BaseState<ForgetPasswordEntity> {
  const ForgetPasswordState({
    super.isLoading,
    super.data,
    super.errorMessage,
  });

  factory ForgetPasswordState.initial() => const ForgetPasswordState();

  factory ForgetPasswordState.loading() =>
      const ForgetPasswordState(isLoading: true);

  factory ForgetPasswordState.success(ForgetPasswordEntity data) =>
      ForgetPasswordState(data: data);

  factory ForgetPasswordState.error(String message) =>
      ForgetPasswordState(errorMessage: message);
}
