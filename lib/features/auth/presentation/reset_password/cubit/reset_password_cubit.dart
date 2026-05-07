import 'package:flower/config/base/base_response.dart';
import 'package:flower/config/base/base_state.dart';
import 'package:flower/features/auth/domain/entities/reset_password_entity.dart';
import 'package:flower/features/auth/domain/usecases/reset_password_usecase.dart';
import 'package:flower/features/auth/presentation/reset_password/cubit/reset_password_intents.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'reset_password_state.dart';

@injectable
class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  final ResetPasswordUseCase _useCase;

  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  ResetPasswordCubit(this._useCase) : super(ResetPasswordState.initial());

  void doIntent(ResetPasswordIntent intent) {
    switch (intent.runtimeType) {
      case SubmitResetPasswordIntent:
        final email = (intent as SubmitResetPasswordIntent).email;
        _submit(email);
        break;
    }
  }

  Future<void> _submit(String email) async {
    emit(state.copyWith(isLoadingParam: true));
    final response = await _useCase(
      email: email,
      newPassword: passwordController.text,
    );

    if (response is SuccessBaseResponse<ResetPasswordEntity>) {
      emit(state.copyWith(isLoadingParam: false, dataParam: response.data));
    } else if (response is ErrorBaseResponse<ResetPasswordEntity>) {
      emit(
        state.copyWith(
          isLoadingParam: false,
          errorMessageParam: response.failure.message,
        ),
      );
    }
  }

  @override
  Future<void> close() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    return super.close();
  }
}
