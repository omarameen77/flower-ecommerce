import 'package:equatable/equatable.dart';
import 'package:flower/config/base/base_response.dart';
import 'package:flower/config/base/base_state.dart';
import 'package:flower/features/auth/domain/entities/change_password_entity.dart';
import 'package:flower/features/auth/domain/use_cases/change_password_usecase.dart';
import 'package:flower/features/auth/presentation/change_password/cubit/change_password_intents.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'change_password_state.dart';

@injectable
class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  final ChangePasswordUseCase _useCase;

  ChangePasswordCubit(this._useCase) : super(const ChangePasswordState());

  void doIntent(ChangePasswordIntent intent) {
    switch (intent) {
      case SubmitChangePasswordIntent():
        _submit(
          oldPassword: intent.oldPassword,
          newPassword: intent.newPassword,
        );
    }
  }

  Future<void> _submit({
    required String oldPassword,
    required String newPassword,
  }) async {
    emit(
      state.copyWith(changePasswordState: const BaseState(isLoading: true)),
    );
    final response = await _useCase(
      oldPassword: oldPassword,
      newPassword: newPassword,
    );
    switch (response) {
      case SuccessBaseResponse<ChangePasswordEntity>():
        emit(
          state.copyWith(changePasswordState: BaseState(data: response.data)),
        );
      case ErrorBaseResponse<ChangePasswordEntity>():
        emit(
          state.copyWith(
            changePasswordState: BaseState(
              errorMessage: response.failure.message,
            ),
          ),
        );
    }
  }
}
