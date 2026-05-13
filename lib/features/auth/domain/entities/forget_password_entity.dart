import 'package:equatable/equatable.dart';

class ForgetPasswordEntity extends Equatable {
  final String message;
  final String info;

  const ForgetPasswordEntity({required this.message, required this.info});

  @override
  List<Object?> get props => [message, info];
}
