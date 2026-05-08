import 'package:equatable/equatable.dart';
import '../../domain/entity/todo.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final List<Todo> todos;

  const ProfileLoaded({required this.todos});

  @override
  List<Object?> get props => [todos];
}

class ProfileError extends ProfileState {
  final String message;

  const ProfileError(this.message);

  @override
  List<Object?> get props => [message];
}
