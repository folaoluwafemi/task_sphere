import 'package:task_sphere/src/entities/productivity_history/productivity_history_barrel.dart';
import 'package:task_sphere/src/entities/task/task_barrel.dart';
import 'package:task_sphere/src/entities/todo/data/source/todos_source_interface.dart';
import 'package:task_sphere/src/entities/todo/todo_barrel.dart';
import 'package:task_sphere/src/utils/utils_barrel.dart';

part 'tasks_repository.dart';

abstract interface class TasksRepoInterface {
  Future<List<Todo>> readTodos({required String taskId});

  Future<void> updateTodos(
    List<Todo> todos, {
    required Task task,
    required bool shouldUpdateHistory,
  });

  Future<void> deleteTodo(
    Todo todo, {
    required Task task,
  });

  Future<void> deleteAllTodos(String taskId);

  Future<void> createTask(Task task);

  Future<void> updateTask(
    Task task, {
    required bool shouldUpdateHistory,
  });

  Future<void> deleteTask(String taskId);
}
