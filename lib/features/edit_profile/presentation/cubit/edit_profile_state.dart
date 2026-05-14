part of 'edit_profile_cubit.dart';

class EditProfileState extends Equatable {
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final BaseState<UserEntity> submitState;

  const EditProfileState({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    this.submitState = const BaseState(),
  });

  EditProfileState copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    BaseState<UserEntity>? submitState,
  }) {
    return EditProfileState(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      submitState: submitState ?? this.submitState,
    );
  }

  @override
  List<Object?> get props => [firstName, lastName, email, phone, submitState];
}
