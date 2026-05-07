import 'package:flower/config/base/base_response.dart';
import 'package:flower/config/base/base_state.dart';
import 'package:flower/features/auth/domain/entities/forget_password_entity.dart';
import 'package:flower/features/auth/domain/usecases/forget_password_usecase.dart';
import 'package:flower/features/auth/presentation/forget_password/cubit/forget_password_intents.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'forget_password_state.dart';

@injectable
class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  final ForgetPasswordUseCase _useCase;

  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  ForgetPasswordCubit(this._useCase) : super(ForgetPasswordState.initial());

  void doIntent(ForgetPasswordIntent intent) {
    switch (intent.runtimeType) {
      case SubmitForgetPasswordIntent:
        _submit();
        break;
    }
  }

  Future<void> _submit() async {
    emit(state.copyWith(isLoadingParam: true));
    final response = await _useCase(email: emailController.text.trim());

    if (response is SuccessBaseResponse<ForgetPasswordEntity>) {
      emit(state.copyWith(isLoadingParam: false, dataParam: response.data));
    } else if (response is ErrorBaseResponse<ForgetPasswordEntity>) {
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
    emailController.dispose();
    return super.close();
  }
}
