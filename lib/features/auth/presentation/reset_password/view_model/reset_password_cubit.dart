import 'package:flower/config/base/base_response.dart';
import 'package:flower/features/auth/domain/models/reset_password_entity.dart';
import 'package:flower/features/auth/domain/usecase/reset_password_use_case.dart';
import 'package:flower/features/auth/presentation/reset_password/view_model/reset_password_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  final ResetPasswordUseCase _useCase;

  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  ResetPasswordCubit(this._useCase) : super(ResetPasswordState.initial());

  void togglePasswordVisibility() => emit(state.togglePassword());

  void toggleConfirmVisibility() => emit(state.toggleConfirm());

  Future<void> submit({required String email}) async {
    final form = formKey.currentState;
    if (form != null && !form.validate()) return;
    emit(state.toLoading());
    final response = await _useCase(
      email: email,
      newPassword: passwordController.text,
    );
    _emitFromResponse(response);
  }

  void _emitFromResponse(BaseResponse<ResetPasswordEntity> response) {
    switch (response) {
      case SuccessBaseResponse<ResetPasswordEntity>():
        emit(state.toSuccess(response.data));
      case ErrorBaseResponse<ResetPasswordEntity>():
        emit(state.toError(response.failure.message));
    }
  }

  @override
  Future<void> close() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    return super.close();
  }
}
