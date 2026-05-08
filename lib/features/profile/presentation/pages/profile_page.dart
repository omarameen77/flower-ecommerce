import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/profile_cubit.dart';
import '../cubit/profile_state.dart';
import '../../domain/entity/todo.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileCubit()..loadTodos(),
      child: const _ProfileView(),
    );
  }
}

class _ProfileView extends StatelessWidget {
  const _ProfileView();

  void _showTodoDialog(BuildContext context, {Todo? todo}) {
    final titleController = TextEditingController(text: todo?.title ?? '');
    final descriptionController = TextEditingController(
      text: todo?.description ?? '',
    );

    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(todo == null ? 'Add Todo' : 'Edit Todo'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final title = titleController.text.trim();
                final description = descriptionController.text.trim();
                if (title.isEmpty || description.isEmpty) {
                  return;
                }

                final cubit = context.read<ProfileCubit>();
                if (todo == null) {
                  cubit.addTodo(title, description);
                } else {
                  cubit.updateTodo(todo.id, title, description);
                }

                Navigator.of(context).pop();
              },
              child: Text(todo == null ? 'Add' : 'Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Todo'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showTodoDialog(context),
          ),
        ],
      ),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoaded) {
            final todos = state.todos;
            if (todos.isEmpty) {
              return const Center(
                child: Text('No todos yet. Tap + to add one.'),
              );
            }

            return ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                final todo = todos[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: ListTile(
                    title: Text(todo.title),
                    subtitle: Text(todo.description),
                    leading: Checkbox(
                      value: todo.isCompleted,
                      onChanged: (_) =>
                          context.read<ProfileCubit>().toggleTodo(todo.id),
                    ),
                    trailing: PopupMenuButton<String>(
                      onSelected: (value) {
                        if (value == 'edit') {
                          _showTodoDialog(context, todo: todo);
                        } else if (value == 'delete') {
                          context.read<ProfileCubit>().deleteTodo(todo.id);
                        }
                      },
                      itemBuilder: (_) => const [
                        PopupMenuItem(value: 'edit', child: Text('Edit')),
                        PopupMenuItem(value: 'delete', child: Text('Delete')),
                      ],
                    ),
                  ),
                );
              },
            );
          }

          if (state is ProfileError) {
            return Center(child: Text(state.message));
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
