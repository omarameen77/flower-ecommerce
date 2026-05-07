import 'package:equatable/equatable.dart';

class ResetPasswordEntity extends Equatable {
  final String message;
  final String token;

  const ResetPasswordEntity({required this.message, required this.token});

  @override
  List<Object?> get props => [message, token];
}
