sealed class LoginEvent {}

class Login extends LoginEvent {
  final String email;
  final String password;

  Login({required this.email, required this.password});
}

class RememberMeChanged extends LoginEvent {
  final bool value;

  RememberMeChanged(this.value);
}
