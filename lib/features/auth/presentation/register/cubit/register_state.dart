
part of 'register_cubit.dart';

class RegisterState extends Equatable {
  final BaseState<UserEntity> registerState;
  final String selectedGender;

  const RegisterState({
    required this.registerState,
    this.selectedGender = '',
  });

  RegisterState copyWith({
    BaseState<UserEntity>? registerState,
    String? selectedGender,
  }) {
    return RegisterState(
      registerState: registerState ?? this.registerState,
      selectedGender: selectedGender ?? this.selectedGender,
    );
  }

  @override
  List<Object?> get props => [registerState, selectedGender];
}
