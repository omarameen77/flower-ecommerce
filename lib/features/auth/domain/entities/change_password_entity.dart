import 'package:equatable/equatable.dart';

class ChangePasswordEntity extends Equatable {
  final String message;
  final String token;

  const ChangePasswordEntity({required this.message, required this.token});

  @override
  List<Object?> get props => [message, token];
}
