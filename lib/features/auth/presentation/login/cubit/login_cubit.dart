import 'package:equatable/equatable.dart';
import 'package:flower/config/base/base_response.dart';
import 'package:flower/config/base/base_state.dart';
import 'package:flower/core/error/error_handler.dart';
import 'package:flower/core/network/model/user_entity.dart';
import 'package:flower/core/storage/secure_storage_service.dart';
import 'package:flower/features/auth/domain/use_cases/login_params.dart';
import 'package:flower/features/auth/domain/use_cases/login_use_case.dart';
import 'package:flower/features/auth/presentation/login/cubit/login_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'login_state.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase _loginUseCase;

  LoginCubit(this._loginUseCase) : super(const LoginState());

  void doEvent(LoginEvent event) {
    switch (event) {
      case Login():
        _login(event);
        break;

      case RememberMeChanged():
        emit(state.copyWith(rememberMe: event.value));
        break;
    }
  }

  Future<void> _login(Login event) async {
    try {
      emit(state.copyWith(loginState: const BaseState(isLoading: true)));

      final result = await _loginUseCase.call(
        LoginParams(email: event.email, password: event.password),
      );

      if (result is SuccessBaseResponse<UserEntity>) {
        final user = result.data;

        if (!state.rememberMe) {
          await SecureStorageService.deleteToken();
        }

        emit(
          state.copyWith(loginState: BaseState(data: user, isLoading: false)),
        );
      } else if (result is ErrorBaseResponse<UserEntity>) {
        emit(
          state.copyWith(
            loginState: BaseState(
              isLoading: false,
              errorMessage: result.failure.message,
            ),
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          loginState: BaseState(
            isLoading: false,
            errorMessage: ErrorHandler.handle(e).message,
          ),
        ),
      );
    }
  }
}
