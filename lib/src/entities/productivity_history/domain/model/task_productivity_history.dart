import 'package:task_sphere/src/entities/productivity_history/domain/model/productivity_snapshot.dart';

extension ProductivitySnapshotsExtension on List<ProductivitySnapshot> {
  Map<String, int> toFirebaseList() {
    return {
      for (final snapshot in this)
        snapshot.dateTime.toIso8601String(): snapshot.value,
    };
  }

  List<Map<String, dynamic>> toSerializerList() {
    return map((e) => e.toMap()).toList();
  }
}

class TaskProductivityHistory implements Comparable<TaskProductivityHistory> {
  final String taskId;
  final List<ProductivitySnapshot> snapshots;

  const TaskProductivityHistory({
    required this.taskId,
    required this.snapshots,
  });

  Map<String, dynamic> toMap() {
    return {
      'taskId': taskId,
      'snapshots': snapshots.map((e) => e.toMap()).toList(),
    };
  }

  int get totalProductivityPoint {
    return snapshots.fold<int>(0, (previousValue, element) {
      return previousValue + element.value;
    });
  }

  factory TaskProductivityHistory.fromMap(Map<String, dynamic> map) {
    return TaskProductivityHistory(
      taskId: map['taskId'] as String,
      snapshots: (map['snapshots'] as List?)
              ?.map((e) => ProductivitySnapshotUtils.fromMap(e))
              .toList() ??
          [],
    );
  }

  TaskProductivityHistory withSnapshots(
    List<ProductivitySnapshot>? snapshots,
  ) {
    return TaskProductivityHistory(
      taskId: taskId,
      snapshots: snapshots ?? this.snapshots,
    );
  }

  TaskProductivityHistory copyWith({
    String? taskId,
    List<ProductivitySnapshot>? snapshots,
  }) {
    return TaskProductivityHistory(
      taskId: taskId ?? this.taskId,
      snapshots: snapshots ?? this.snapshots,
    );
  }

  @override
  int compareTo(TaskProductivityHistory other) {
    return other.taskId.compareTo(taskId);
  }

  @override
  String noSuchMethod(Invocation invocation) {
    return 'This method does not exist';
  }
}
