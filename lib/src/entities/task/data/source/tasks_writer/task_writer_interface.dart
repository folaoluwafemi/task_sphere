import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_sphere/src/entities/apis/firebase/firebase_api_barrel.dart';
import 'package:task_sphere/src/entities/task/task_barrel.dart';
import 'package:task_sphere/src/entities/user/user_barrel.dart';
import 'package:task_sphere/src/utils/constants/constants_barrel.dart';

part 'tasks_writer.dart';

abstract interface class TaskWriterInterface {
  Future<void> createTask(Task task);

  Future<void> updateTask(Task task);

  Future<void> deleteTask(String taskId);
}
