part of 'login_cubit.dart';

class LoginState extends Equatable {
  final BaseState<UserEntity> loginState;
  final bool rememberMe;

  const LoginState({
    this.loginState = const BaseState(),
    this.rememberMe = false,
  });

  LoginState copyWith({BaseState<UserEntity>? loginState, bool? rememberMe}) {
    return LoginState(
      loginState: loginState ?? this.loginState,
      rememberMe: rememberMe ?? this.rememberMe,
    );
  }

  @override
  List<Object?> get props => [loginState, rememberMe];
}
