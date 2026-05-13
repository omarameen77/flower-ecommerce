import 'package:flower/config/base/base_response.dart';
import 'package:flower/config/base/base_state.dart';
import 'package:flower/core/error/error_handler.dart';
import 'package:flower/core/network/model/user_entity.dart';
import 'package:flower/features/auth/domain/use_cases/register_use_case.dart';
import 'register_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:equatable/equatable.dart';
import 'package:flower/features/auth/domain/use_cases/register_params.dart';

part 'register_state.dart';

@injectable
class RegisterCubit extends Cubit<RegisterState> {
  final RegisterUseCase _registerUseCase;

  RegisterCubit(this._registerUseCase) : super(const RegisterState());

  void doEvent(RegisterEvent event) {
    switch (event) {
      case Register():
        _register(event);
        break;
      case ChangeGender():
        emit(state.copyWith(selectedGender: event.gender));
        break;
    }
  }

  Future<void> _register(Register event) async {
    try {
      emit(state.copyWith(registerState: BaseState(isLoading: true)));

      final result = await _registerUseCase.call(
        RegisterParams(
          firstName: event.firstName,
          lastName: event.lastName,
          email: event.email,
          password: event.password,
          rePassword: event.rePassword,
          phone: event.phone,
          gender: event.gender,
        ),
      );

      switch (result) {
        case SuccessBaseResponse<UserEntity>():
          emit(
            state.copyWith(
              registerState: BaseState(data: result.data, isLoading: false),
            ),
          );
        case ErrorBaseResponse<UserEntity>():
          emit(
            state.copyWith(
              registerState: BaseState(
                isLoading: false,
                errorMessage: result.failure.message,
              ),
            ),
          );
      }
    } catch (e) {
      emit(
        state.copyWith(
          registerState: BaseState(
            isLoading: false,
            errorMessage: ErrorHandler.handle(e).message,
          ),
        ),
      );
    }
  }
}
