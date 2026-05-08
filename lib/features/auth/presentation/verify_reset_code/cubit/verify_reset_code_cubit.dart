import 'package:equatable/equatable.dart';
import 'package:flower/config/base/base_response.dart';
import 'package:flower/config/base/base_state.dart';
import 'package:flower/features/auth/domain/entities/verify_reset_code_entity.dart';
import 'package:flower/features/auth/domain/usecases/forget_password_usecase.dart';
import 'package:flower/features/auth/domain/usecases/verify_reset_code_usecase.dart';
import 'package:flower/features/auth/presentation/verify_reset_code/cubit/verify_reset_code_intents.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'verify_reset_code_state.dart';

@injectable
class VerifyResetCodeCubit extends Cubit<VerifyResetCodeState> {
  final VerifyResetCodeUseCase _verifyUseCase;
  final ForgetPasswordUseCase _forgetPasswordUseCase;

  VerifyResetCodeCubit(this._verifyUseCase, this._forgetPasswordUseCase)
    : super(const VerifyResetCodeState());

  void doIntent(VerifyResetCodeIntent intent) {
    switch (intent.runtimeType) {
      case VerifyIntent:
        _verify((intent as VerifyIntent).code);
        break;
      case ResendIntent:
        _resend((intent as ResendIntent).email);
        break;
      case ClearResendStatusIntent:
        _clearResendStatus();
        break;
    }
  }

  Future<void> _verify(String code) async {
    emit(
      state.copyWith(
        base: const BaseState(isLoading: true),
        hasError: false,
      ),
    );
    final response = await _verifyUseCase(resetCode: code);
    switch (response) {
      case SuccessBaseResponse<VerifyResetCodeEntity>():
        if (response.data.isValid) {
          emit(state.copyWith(base: BaseState(data: response.data)));
        } else {
          emit(state.copyWith(base: const BaseState(), hasError: true));
        }
        break;
      case ErrorBaseResponse<VerifyResetCodeEntity>():
        emit(
          state.copyWith(
            base: BaseState(errorMessage: response.failure.message),
            hasError: true,
          ),
        );
        break;
    }
  }

  Future<void> _resend(String email) async {
    if (state.isResending) return;
    emit(
      state.copyWith(
        isResending: true,
        resendSucceeded: false,
        resendErrorMessage: null,
      ),
    );
    final response = await _forgetPasswordUseCase(email: email);
    switch (response) {
      case SuccessBaseResponse():
        emit(state.copyWith(isResending: false, resendSucceeded: true));
        break;
      case ErrorBaseResponse():
        emit(
          state.copyWith(
            isResending: false,
            resendErrorMessage: response.failure.message,
          ),
        );
        break;
    }
  }

  void _clearResendStatus() {
    emit(
      VerifyResetCodeState(
        base: state.base,
        hasError: state.hasError,
        isResending: false,
        resendSucceeded: false,
        resendErrorMessage: null,
      ),
    );
  }
}
