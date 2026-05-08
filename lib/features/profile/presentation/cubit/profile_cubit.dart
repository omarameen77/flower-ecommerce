import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

import '../../domain/entity/todo.dart';
import 'profile_state.dart';

@injectable
class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  final List<Todo> _todos = [];
  final _uuid = Uuid();

  void loadTodos() {
    emit(ProfileLoaded(todos: _todos));
  }

  void addTodo(String title, String description) {
    final todo = Todo(
      id: _uuid.v4(),
      title: title,
      description: description,
      isCompleted: false,
      createdAt: DateTime.now(),
    );
    _todos.add(todo);
    emit(ProfileLoaded(todos: _todos));
  }

  void updateTodo(String id, String title, String description) {
    final index = _todos.indexWhere((t) => t.id == id);
    if (index != -1) {
      _todos[index] = _todos[index].copyWith(title: title, description: description);
      emit(ProfileLoaded(todos: _todos));
    }
  }

  void toggleTodo(String id) {
    final index = _todos.indexWhere((t) => t.id == id);
    if (index != -1) {
      final todo = _todos[index];
      _todos[index] = todo.copyWith(isCompleted: !todo.isCompleted);
      emit(ProfileLoaded(todos: _todos));
    }
  }

  void deleteTodo(String id) {
    _todos.removeWhere((t) => t.id == id);
    emit(ProfileLoaded(todos: _todos));
  }
}