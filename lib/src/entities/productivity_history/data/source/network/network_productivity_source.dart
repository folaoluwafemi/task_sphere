import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_sphere/src/entities/entities_barrel.dart';
import 'package:task_sphere/src/entities/productivity_history/domain/model/productivity_history.dart';
import 'package:task_sphere/src/entities/productivity_history/domain/model/productivity_snapshot.dart';
import 'package:task_sphere/src/entities/productivity_history/domain/model/task_productivity_history.dart';
import 'package:task_sphere/src/utils/utils_barrel.dart';

part 'firebase_productivity_history.dart';

abstract interface class NetworkProductivityHistorySourceInterface {
  Future<void> addSnapshot({
    required String taskId,
    required ProductivitySnapshot snapshot,
  });

  Future<TaskProductivityHistory?> fetchHistoryFor(String taskId);

  Future<void> removeHistoryFor(String taskId);

  Future<void> uploadHistory(ProductivityHistory history);

  Future<ProductivityHistory> fetchAll();
}
