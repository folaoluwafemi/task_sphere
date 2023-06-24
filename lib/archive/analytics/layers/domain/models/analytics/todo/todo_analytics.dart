import 'package:task_sphere/archive/analytics/layers/domain/analytics_domain_barrel.dart';
import 'package:task_sphere/src/utils/utils_barrel.dart';

final class TodoAnalytics extends Analytics {
  final TodoAnalyticsData? analyticsData;

  const TodoAnalytics({
    required super.id,
    required this.analyticsData,
    required super.action,
    required super.timestamp,
  }) : super(
          type: AnalyticsDataType.todo,
          data: analyticsData,
        );

  TodoAnalytics.create({
    required this.analyticsData,
    required super.action,
  }) : super(
          id: UtilFunctions.generateId(),
          type: AnalyticsDataType.todo,
          data: analyticsData,
          timestamp: DateTime.now(),
        );

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type.name,
      'data': analyticsData?.toMap(),
      'action': action.name,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  factory TodoAnalytics.fromMap(Map<String, dynamic> map) {
    return TodoAnalytics(
      id: map['id'],
      analyticsData: TodoAnalyticsData.fromMap((map['data'] as Map).cast()),
      action: AnalyticsAction.fromName(map['action'] as String),
      timestamp: UtilFunctions.parseDateTime(map['timestamp'] as String),
    );
  }
}
