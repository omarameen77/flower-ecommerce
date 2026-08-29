import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flower/config/base/base_response.dart';
import 'package:flower/config/base/base_state.dart';
import 'package:flower/features/auth/domain/entities/forget_password_entity.dart';
import 'package:flower/features/auth/domain/entities/verify_reset_code_entity.dart';
import 'package:flower/features/auth/domain/use_cases/forget_password_usecase.dart';
import 'package:flower/features/auth/domain/use_cases/verify_reset_code_usecase.dart';
import 'package:flower/features/auth/presentation/forget_password/cubit/forget_password_intents.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'forget_password_state.dart';

@injectable
class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  final ForgetPasswordUseCase _forgetPasswordUseCase;
  final VerifyResetCodeUseCase _verifyResetCodeUseCase;

  ForgetPasswordCubit(this._forgetPasswordUseCase, this._verifyResetCodeUseCase)
    : super(const ForgetPasswordState());

  void doIntent(ForgetPasswordIntent intent) {
    if (intent is SubmitForgetPasswordIntent) {
      _submit(intent.email);
    }

    if (intent is VerifyResetCodeIntent) {
      _verifyResetCode(intent.resetCode);
    }
  }

  Future<void> _submit(String email) async {
    emit(state.copyWith(base: const BaseState(isLoading: true), email: email));

    final response = await _forgetPasswordUseCase(email: email);

    if (response is SuccessBaseResponse<ForgetPasswordEntity>) {
      emit(state.copyWith(base: BaseState(data: response.data)));
    } else if (response is ErrorBaseResponse<ForgetPasswordEntity>) {
      emit(
        state.copyWith(base: BaseState(errorMessage: response.failure.message)),
      );
    }
  }

  Future<void> _verifyResetCode(String code) async {
    emit(
      state.copyWith(
        isVerifyingCode: true,
        clearCodeValidation: true,
        clearCodeError: true,
        codeVerified: false,
      ),
    );

    final response = await _verifyResetCodeUseCase(resetCode: code);

    if (response is SuccessBaseResponse<VerifyResetCodeEntity>) {
      final isValid = response.data.status == 'Success';

      if (!isValid) {
        emit(
          state.copyWith(
            isVerifyingCode: false,
            isCodeValid: false,
            codeErrorMessage: 'auth.invalid_code'.tr(),
          ),
        );

        return;
      }

      emit(
        state.copyWith(
          isVerifyingCode: false,
          isCodeValid: true,
          codeErrorMessage: null,
        ),
      );

      await Future.delayed(const Duration(seconds: 2));

      emit(state.copyWith(codeVerified: true));

      return;
    }

    if (response is ErrorBaseResponse<VerifyResetCodeEntity>) {
      emit(
        state.copyWith(
          isVerifyingCode: false,
          isCodeValid: false,
          codeErrorMessage: response.failure.message,
        ),
      );
    }
  }
}
