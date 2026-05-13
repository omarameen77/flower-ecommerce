sealed class RegisterEvent {}

class Register extends RegisterEvent {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String rePassword;
  final String phone;
  final String gender;

  Register({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.rePassword,
    required this.phone,
    required this.gender,
  });
}

class ChangeGender extends RegisterEvent {
  final String gender;
  ChangeGender(this.gender);
}
