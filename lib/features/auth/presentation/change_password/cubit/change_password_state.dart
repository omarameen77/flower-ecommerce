part of 'change_password_cubit.dart';

class ChangePasswordState extends Equatable {
  final BaseState<ChangePasswordEntity> changePasswordState;

  const ChangePasswordState({
    this.changePasswordState = const BaseState(),
  });

  ChangePasswordState copyWith({
    BaseState<ChangePasswordEntity>? changePasswordState,
  }) {
    return ChangePasswordState(
      changePasswordState: changePasswordState ?? this.changePasswordState,
    );
  }

  @override
  List<Object?> get props => [changePasswordState];
}
