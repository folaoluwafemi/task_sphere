import 'package:task_sphere/archive/analytics/layers/domain/analytics_domain_barrel.dart';
import 'package:task_sphere/src/utils/functions/util_functions.dart';

final class TaskAnalytics extends Analytics {
  final String taskId;

  const TaskAnalytics({
    required super.id,
    required this.taskId,
    required super.action,
    required super.timestamp,
  }) : super(
          type: AnalyticsDataType.task,
          data: taskId,
        );

  TaskAnalytics.create({
    required this.taskId,
    required super.action,
  }) : super(
          id: UtilFunctions.generateId(),
          type: AnalyticsDataType.task,
          data: taskId,
          timestamp: DateTime.now(),
        );

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type.name,
      'data': taskId,
      'action': action.name,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  factory TaskAnalytics.fromMap(Map<String, dynamic> map) {
    return TaskAnalytics(
      id: map['id'],
      taskId: map['data'],
      action: AnalyticsAction.fromName(map['action']),
      timestamp: UtilFunctions.parseDateTime(map['timestamp']),
    );
  }
}
