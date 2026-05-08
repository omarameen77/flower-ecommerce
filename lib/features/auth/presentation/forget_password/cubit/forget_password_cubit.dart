import 'package:equatable/equatable.dart';
import 'package:flower/config/base/base_response.dart';
import 'package:flower/config/base/base_state.dart';
import 'package:flower/features/auth/domain/entities/forget_password_entity.dart';
import 'package:flower/features/auth/domain/usecases/forget_password_usecase.dart';
import 'package:flower/features/auth/presentation/forget_password/cubit/forget_password_intents.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'forget_password_state.dart';

@injectable
class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  final ForgetPasswordUseCase _useCase;

  ForgetPasswordCubit(this._useCase) : super(const ForgetPasswordState());

  void doIntent(ForgetPasswordIntent intent) {
    switch (intent.runtimeType) {
      case SubmitForgetPasswordIntent:
        final email = (intent as SubmitForgetPasswordIntent).email;
        _submit(email);
        break;
    }
  }

  Future<void> _submit(String email) async {
    emit(
      state.copyWith(
        base: const BaseState(isLoading: true),
        email: email,
      ),
    );
    final response = await _useCase(email: email);
    switch (response) {
      case SuccessBaseResponse<ForgetPasswordEntity>():
        emit(state.copyWith(base: BaseState(data: response.data)));
        break;
      case ErrorBaseResponse<ForgetPasswordEntity>():
        emit(
          state.copyWith(
            base: BaseState(errorMessage: response.failure.message),
          ),
        );
        break;
    }
  }
}
