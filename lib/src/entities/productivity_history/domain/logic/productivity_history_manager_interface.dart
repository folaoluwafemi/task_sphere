import 'package:task_sphere/src/entities/productivity_history/data/source/network/network_productivity_source.dart';
import 'package:task_sphere/src/entities/productivity_history/productivity_history_barrel.dart';
import 'package:task_sphere/src/entities/task/task_barrel.dart';
import 'package:task_sphere/src/utils/utils_barrel.dart';

part 'productivity_history_manager.dart';

abstract interface class ProductivityHistoryManagerInterface {
  Future<void> pushSnapshotFrom(Task task);

  Future<TaskProductivityHistory?> fetchHistoryFor(String taskId);

  Future<void> deleteHistoryFor(String taskId);

  ProductivityHistory get currentHistory;

  List<ProductivitySnapshot> get snapshots;

  Future<void> fetchHistory();
}
