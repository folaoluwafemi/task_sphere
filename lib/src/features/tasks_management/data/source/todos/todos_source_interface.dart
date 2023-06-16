import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_sphere/src/entities/entities_barrel.dart';
import 'package:task_sphere/src/features/tasks_management/task_management_barrel.dart';
import 'package:task_sphere/src/utils/utils_barrel.dart';

part 'todos_source.dart';

abstract interface class TodoSourceInterface {
  Future<void> addTodo(Todo todo);

  Future<List<Todo>> readTodos();

  Future<void> updateTodo(Todo todo);

  Future<void> updateTodoPriority({
    required String todoId,
    required Priority priority,
  });

  Future<void> updateTodoStatus({
    required String todoId,
    required Status status,
  });

  Future<void> deleteTodo(Todo todo);

  Future<void> deleteAllTodos();
}
