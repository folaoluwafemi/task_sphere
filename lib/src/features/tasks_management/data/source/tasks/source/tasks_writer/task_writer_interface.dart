import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_sphere/src/entities/apis/firebase/firebase_api_barrel.dart';
import 'package:task_sphere/src/entities/user/user_barrel.dart';
import 'package:task_sphere/src/features/tasks_management/task_management_barrel.dart';
import 'package:task_sphere/src/utils/constants/constants_barrel.dart';

part 'tasks_source.dart';

abstract interface class TaskSourceInterface {
  Future<void> createTask(Task task);

  Future<List<Task>> readTasks();

  Future<void> updateTask(Task task);

  Future<void> deleteTask(String taskId);
}
