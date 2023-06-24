import 'package:task_sphere/src/entities/productivity_history/productivity_history_barrel.dart';
import 'package:task_sphere/src/utils/utils_barrel.dart';

typedef ProductivityHistory = List<TaskProductivityHistory>;

extension ProductivityHistoryExtension on ProductivityHistory {
  List<Map<String, dynamic>> toSerializerList() {
    return map((e) => e.toMap()).toList();
  }

  void addTaskHistory(TaskProductivityHistory taskHistory) {
    if (containsWhere((element) => element.taskId == taskHistory.taskId)) {
      final int index = indexWhere((element) {
        return element.taskId == taskHistory.taskId;
      });

      final List<ProductivitySnapshot> snapshots = {
        ...this[index].snapshots,
        ...taskHistory.snapshots,
      }.toList()
        ..sort(ProductivitySnapshotUtils.compare);
      add(
        TaskProductivityHistory(
          taskId: taskHistory.taskId,
          snapshots: snapshots,
        ),
      );
    } else {
      add(taskHistory);
    }
  }
}
