part of 'forget_password_cubit.dart';

class ForgetPasswordState extends Equatable {
  final BaseState<ForgetPasswordEntity> base;
  final String email;

  const ForgetPasswordState({
    this.base = const BaseState(),
    this.email = '',
  });

  ForgetPasswordState copyWith({
    BaseState<ForgetPasswordEntity>? base,
    String? email,
  }) {
    return ForgetPasswordState(
      base: base ?? this.base,
      email: email ?? this.email,
    );
  }

  @override
  List<Object?> get props => [base, email];
}
