import 'package:task_sphere/src/features/tasks_management/task_management_barrel.dart';
import 'package:task_sphere/src/utils/state_management/state_management_utils.dart';

class ProgressiveAnalyticsVanilla extends VanillaNotifier {
  late final TasksReader _reader = TasksReader();

  ProgressiveAnalyticsVanilla() : super(null);
  void computeAnalytics() {
    final List<Task> tasks = _reader.tasks;
    final List<TaskAnalyticsPoint> tasksPoints = [];

    for (final Task task in tasks) {
      int point = task.todos.fold<int>(0, (previousValue, todo) {
        final int todoPoint = todo.priority.value * todo.status.multiplier;
        return previousValue + todoPoint;
      });
      point += 1; // for creating the task
      if (task.isCompleted) point += 1; // for completing a task;

      tasksPoints.add(
        (
        taskId: task.id,
        point: point,
        updatedAt: task.updatedAt,
        createdAt: task.createdAt,
        ),
      );
    }
  }

}
