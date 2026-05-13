part of 'reset_password_cubit.dart';

class ResetPasswordState extends Equatable {
  final BaseState<ResetPasswordEntity> base;

  const ResetPasswordState({this.base = const BaseState()});

  ResetPasswordState copyWith({BaseState<ResetPasswordEntity>? base}) {
    return ResetPasswordState(base: base ?? this.base);
  }

  @override
  List<Object?> get props => [base];
}
