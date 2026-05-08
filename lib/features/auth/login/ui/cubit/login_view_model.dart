

import 'package:flower/config/base/base_response.dart';
import 'package:flower/core/storage/secure_storage_service.dart';
import 'package:flower/features/auth/login/domain/entity/login_request.dart';
import 'package:flower/features/auth/login/domain/entity/login_response.dart';
import 'package:flower/features/auth/login/domain/usecase/login_use_case.dart';
import 'package:flower/features/auth/login/ui/cubit/login_intint.dart';
import 'package:flower/features/auth/login/ui/cubit/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginViewModel extends Cubit<LoginState> {
  final LoginUseCase useCase;
  final SecureStorageService storage;

  LoginViewModel(this.useCase, this.storage) : super(const LoginState());

  String email = "";
  String password = "";

  void doIntent(LoginIntent intent) {
    switch (intent) {
      case EmailChanged():
        email = intent.email;
        _validate();
        break;

      case PasswordChanged():
        password = intent.password;
        _validate();
        break;

      case RememberMeChanged():
        emit(state.copyWith(rememberMe: intent.value));
        break;

      case LoginPressed():
        _login();
        break;
    }
  }

  void _validate() {
    final isValid = email.isNotEmpty && password.isNotEmpty;
    emit(state.copyWith(isFormValid: isValid));
  }

  Future<void> _login() async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final response = await useCase.execute(
      LoginRequest(email: email, password: password),
    );

    switch (response) {
      case SuccessBaseResponse<LoginResponse>():
        final token = response.data.token;

        if (token != null && token.isNotEmpty) {
          await SecureStorageService.saveToken(token);
        }

        emit(
          state.copyWith(
            isLoading: false,
            user: response.data.user,
          ),
        );
        break;
      case ErrorBaseResponse<LoginResponse>():
        emit(
          state.copyWith(
            isLoading: false,
            errorMessage: response.failure.message,
          ),
        );
        break;
      case SuccessBaseResponse<dynamic>():
        // TODO: Handle this case.
        throw UnimplementedError();
      case ErrorBaseResponse<dynamic>():
        // TODO: Handle this case.
        throw UnimplementedError();
    }
  }
}