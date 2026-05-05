import 'package:flower/config/base/base_response.dart';
import 'package:flower/features/auth/domain/models/forget_password_entity.dart';
import 'package:flower/features/auth/domain/usecase/forget_password_use_case.dart';
import 'package:flower/features/auth/presentation/forget_password/view_model/forget_password_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  final ForgetPasswordUseCase _useCase;

  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  ForgetPasswordCubit(this._useCase) : super(ForgetPasswordState.initial());

  Future<void> submit() async {
    final form = formKey.currentState;
    if (form != null && !form.validate()) return;
    emit(ForgetPasswordState.loading());
    final response = await _useCase(email: emailController.text.trim());
    _emitFromResponse(response);
  }

  void _emitFromResponse(BaseResponse<ForgetPasswordEntity> response) {
    switch (response) {
      case SuccessBaseResponse<ForgetPasswordEntity>():
        emit(ForgetPasswordState.success(response.data));
      case ErrorBaseResponse<ForgetPasswordEntity>():
        emit(ForgetPasswordState.error(response.failure.message));
    }
  }

  @override
  Future<void> close() {
    emailController.dispose();
    return super.close();
  }
}
