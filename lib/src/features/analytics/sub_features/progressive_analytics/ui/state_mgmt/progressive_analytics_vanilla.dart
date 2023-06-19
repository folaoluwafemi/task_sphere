import 'package:task_sphere/src/entities/task/task_barrel.dart';
import 'package:task_sphere/src/utils/utils_barrel.dart';

part 'progressive_analytics_state.dart';

class ProgressiveAnalyticsVanilla extends VanillaNotifier {
  late final TasksReader _reader = TasksReader();

  ProgressiveAnalyticsVanilla() : super(null);

  ProgressiveAnalysis _computeAnalysisFrom(List<Task> tasks) {
    final ProgressiveAnalysis analysis = {};
    for(final Task task in tasks){




    }

  }
}
