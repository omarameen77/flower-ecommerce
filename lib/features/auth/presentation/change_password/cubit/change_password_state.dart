part of 'change_password_cubit.dart';

class ChangePasswordState extends Equatable {
  final BaseState<ChangePasswordEntity> base;

  const ChangePasswordState({this.base = const BaseState()});

  ChangePasswordState copyWith({BaseState<ChangePasswordEntity>? base}) {
    return ChangePasswordState(base: base ?? this.base);
  }

  @override
  List<Object?> get props => [base];
}
