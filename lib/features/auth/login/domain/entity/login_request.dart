import 'package:flower/features/auth/login/data/model/login_request_dto.dart';

class LoginRequest {
  final String email;
  final String password;

  LoginRequest({
    required this.email,
    required this.password,
  });

   LoginRequestDTO toDTO() => LoginRequestDTO(email: email, password: password);
}