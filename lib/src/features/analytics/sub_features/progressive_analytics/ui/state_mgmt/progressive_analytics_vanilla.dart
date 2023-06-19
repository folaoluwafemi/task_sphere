import 'package:task_sphere/src/entities/task/task_barrel.dart';
import 'package:task_sphere/src/utils/state_management/state_management_utils.dart';

class ProgressiveAnalyticsVanilla extends VanillaNotifier {
  late final TasksReader _reader = TasksReader();

  ProgressiveAnalyticsVanilla() : super(null);

  void computeAnalytics() {
    final List<Task> tasks = _reader.tasks;

    for (final Task task in tasks) {}
  }
}
