import 'package:flower/features/auth/login/domain/entity/user.dart';

class LoginResponse {
    String? message;
    String? token;
    User? user;

  LoginResponse({this.message, required this.user,required this.token});
}
