import 'package:equatable/equatable.dart';
import 'package:flower/config/base/base_response.dart';
import 'package:flower/config/base/base_state.dart';
import 'package:flower/features/auth/domain/entities/reset_password_entity.dart';
import 'package:flower/features/auth/domain/use_cases/reset_password_usecase.dart';
import 'package:flower/features/auth/presentation/reset_password/cubit/reset_password_intents.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'reset_password_state.dart';

@injectable
class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  final ResetPasswordUseCase _useCase;

  ResetPasswordCubit(this._useCase) : super(const ResetPasswordState());

  void doIntent(ResetPasswordIntent intent) {
    switch (intent.runtimeType) {
      case SubmitResetPasswordIntent:
        final i = intent as SubmitResetPasswordIntent;
        _submit(email: i.email, newPassword: i.newPassword);
        break;
    }
  }

  Future<void> _submit({
    required String email,
    required String newPassword,
  }) async {
    emit(state.copyWith(base: const BaseState(isLoading: true)));
    final response = await _useCase(email: email, newPassword: newPassword);
    switch (response) {
      case SuccessBaseResponse<ResetPasswordEntity>():
        emit(state.copyWith(base: BaseState(data: response.data)));
        break;
      case ErrorBaseResponse<ResetPasswordEntity>():
        emit(
          state.copyWith(
            base: BaseState(errorMessage: response.failure.message),
          ),
        );
        break;
    }
  }
}
