import 'package:flower/features/auth/login/domain/entity/user.dart';

class LoginState {
  final bool isFormValid;
  final bool rememberMe;
  final bool isLoading;

  final User? user;
  final String? errorMessage;

  const LoginState({
    this.isFormValid = false,
    this.rememberMe = false,
    this.isLoading = false,
    this.user,
    this.errorMessage,
  });

  LoginState copyWith({
    bool? isFormValid,
    bool? rememberMe,
    bool? isLoading,
    User? user,
    String? errorMessage,
  }) {
    return LoginState(
      isFormValid: isFormValid ?? this.isFormValid,
      rememberMe: rememberMe ?? this.rememberMe,
      isLoading: isLoading ?? this.isLoading,
      user: user ?? this.user,
      errorMessage: errorMessage,
    );
  }
}