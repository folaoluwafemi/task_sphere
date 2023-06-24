import 'package:hive_flutter/hive_flutter.dart';
import 'package:task_sphere/src/entities/productivity_history/domain/model/productivity_history.dart';
import 'package:task_sphere/src/entities/productivity_history/domain/model/productivity_snapshot.dart';
import 'package:task_sphere/src/entities/productivity_history/domain/model/task_productivity_history.dart';
import 'package:task_sphere/src/utils/utils_barrel.dart';

part 'productivity_history_source.dart';

abstract interface class LocalProductivityHistorySourceInterface {
  Future<void> addSnapshot({
    required String taskId,
    required ProductivitySnapshot snapshot,
  });

  TaskProductivityHistory? fetchHistoryFor(String taskId);

  Future<void> removeHistoryFor(String taskId);

  ProductivityHistory fetchAll();
}
