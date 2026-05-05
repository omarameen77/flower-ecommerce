import 'package:flower/config/base/base_response.dart';
import 'package:flower/features/auth/domain/models/forget_password_entity.dart';
import 'package:flower/features/auth/domain/models/verify_reset_code_entity.dart';
import 'package:flower/features/auth/domain/usecase/forget_password_use_case.dart';
import 'package:flower/features/auth/domain/usecase/verify_reset_code_use_case.dart';
import 'package:flower/features/auth/presentation/verify_reset_code/view_model/verify_reset_code_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class VerifyResetCodeCubit extends Cubit<VerifyResetCodeState> {
  final VerifyResetCodeUseCase _verifyUseCase;
  final ForgetPasswordUseCase _forgetPasswordUseCase;

  VerifyResetCodeCubit(this._verifyUseCase, this._forgetPasswordUseCase)
    : super(VerifyResetCodeState.initial());

  Future<void> verify(String code) async {
    emit(VerifyResetCodeState.loading());
    final response = await _verifyUseCase(resetCode: code);
    _emitFromResponse(response);
  }

  void _emitFromResponse(BaseResponse<VerifyResetCodeEntity> response) {
    switch (response) {
      case SuccessBaseResponse<VerifyResetCodeEntity>():
        if (response.data.isValid) {
          emit(VerifyResetCodeState.success(response.data));
        } else {
          emit(VerifyResetCodeState.error('Invalid code'));
        }
      case ErrorBaseResponse<VerifyResetCodeEntity>():
        emit(VerifyResetCodeState.error(response.failure.message));
    }
  }

  Future<BaseResponse<ForgetPasswordEntity>> resend({
    required String email,
  }) {
    return _forgetPasswordUseCase(email: email);
  }

  void clearError() => emit(VerifyResetCodeState.initial());
}
