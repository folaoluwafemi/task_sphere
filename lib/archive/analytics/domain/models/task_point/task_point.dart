import 'package:task_sphere/src/features/features_barrel.dart';

class TaskPoint {
  final Task task;
  final int point;

  const TaskPoint({
    required this.task,
    required this.point,
  });

  TaskPoint copyWith({
    Task? task,
    int? point,
  }) {
    return TaskPoint(
      task: task ?? this.task,
      point: point ?? this.point,
    );
  }
}
