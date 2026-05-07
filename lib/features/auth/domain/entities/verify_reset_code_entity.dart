import 'package:equatable/equatable.dart';

class VerifyResetCodeEntity extends Equatable {
  final String status;

  const VerifyResetCodeEntity({required this.status});

  bool get isValid => status.toLowerCase() == 'success';

  @override
  List<Object?> get props => [status];
}
