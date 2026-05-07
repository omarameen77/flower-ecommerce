import 'package:flower/config/base/base_response.dart';
import 'package:flower/config/base/base_state.dart';
import 'package:flower/features/auth/domain/entities/forget_password_entity.dart';
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
    : super(VerifyResetCodeState.initial());

  void doIntent(VerifyResetCodeIntent intent) {
    switch (intent.runtimeType) {
      case VerifyIntent:
        final code = (intent as VerifyIntent).code;
        _verify(code);
        break;
      case ResendIntent:
        final email = (intent as ResendIntent).email;
        _resend(email);
        break;
      case ClearResendStatusIntent:
        _clearResendStatus();
        break;
    }
  }

  void _clearResendStatus() {
    emit(
      VerifyResetCodeState(
        isLoading: state.isLoading,
        data: state.data,
        errorMessage: state.errorMessage,
        hasError: state.hasError,
        isResending: false,
        resendSucceeded: false,
        resendErrorMessage: null,
      ),
    );
  }

  Future<void> _verify(String code) async {
    emit(state.copyWith(isLoadingParam: true, hasError: false));
    final response = await _verifyUseCase(resetCode: code);

    if (response is SuccessBaseResponse<VerifyResetCodeEntity>) {
      if (response.data.isValid) {
        emit(state.copyWith(isLoadingParam: false, dataParam: response.data));
      } else {
        emit(
          state.copyWith(
            isLoadingParam: false,
            hasError: true,
            errorMessageParam: 'Invalid code',
          ),
        );
      }
    } else if (response is ErrorBaseResponse<VerifyResetCodeEntity>) {
      emit(
        state.copyWith(
          isLoadingParam: false,
          hasError: true,
          errorMessageParam: response.failure.message,
        ),
      );
    }
  }

  Future<void> _resend(String email) async {
    if (state.isResending) return;
    emit(state.copyWith(isResending: true));
    final response = await _forgetPasswordUseCase(email: email);

    if (response is SuccessBaseResponse<ForgetPasswordEntity>) {
      emit(state.copyWith(isResending: false, resendSucceeded: true));
    } else if (response is ErrorBaseResponse<ForgetPasswordEntity>) {
      emit(
        state.copyWith(
          isResending: false,
          resendErrorMessage: response.failure.message,
        ),
      );
    }
  }
}
