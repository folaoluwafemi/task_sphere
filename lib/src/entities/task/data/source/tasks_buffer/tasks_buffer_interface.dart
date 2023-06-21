import 'package:hive_flutter/hive_flutter.dart';
import 'package:task_sphere/src/entities/task/task_barrel.dart';
import 'package:task_sphere/src/utils/utils_barrel.dart';

part 'tasks_buffer.dart';

abstract interface class TasksBufferInterface {
  List<Task> fetchTasks();

  Future<void> removeTask(String taskId);

  Future<void> updateTask(Task task);

  Future<void> addTask(Task task);

  Future<void> addMultiple(List<Task> tasks);

  Future<void> clear();
}
