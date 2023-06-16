import 'package:task_sphere/src/features/analytics/analytics_barrel.dart';
import 'package:task_sphere/src/features/tasks_management/data/source/todos/todos_source_interface.dart';
import 'package:task_sphere/src/features/tasks_management/task_management_barrel.dart';

part 'tasks_repository.dart';

abstract interface class TasksRepoInterface {
  Future<void> addTodo(
    Todo todo, {
    required String taskId,
  });

  Future<List<Todo>> readTodos({required String taskId});

  Future<void> updateTodos(
    List<Todo> todos, {
    required String taskId,
  });

  Future<void> deleteTodo(
    Todo todo, {
    required String taskId,
  });

  Future<void> createTask(Task task);

  Future<void> updateTask(Task task);

  Future<void> deleteTask(String taskId);
}
