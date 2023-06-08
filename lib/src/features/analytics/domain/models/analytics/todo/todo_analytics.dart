import 'package:task_sphere/src/features/analytics/domain/analytics_domain_barrel.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_sphere/src/utils/utils_barrel.dart';

final class TodoAnalytics extends Analytics {
  final TodoAnalyticsData? updateData;

  const TodoAnalytics({
    required super.id,
    required this.updateData,
    required super.action,
    required super.timestamp,
  }) : super(
          type: AnalyticsDataType.todo,
          data: updateData,
        );

  TodoAnalytics.create({
    required this.updateData,
    required super.action,
  }) : super(
          id: UtilFunctions.generateId(),
          type: AnalyticsDataType.todo,
          data: updateData,
          timestamp: DateTime.now(),
        );

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'data': updateData?.toMap(),
      'action': action.name,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  factory TodoAnalytics.fromMap(Map<String, dynamic> map) {
    return TodoAnalytics(
      id: map['id'],
      updateData: TodoAnalyticsData.fromMap(map['data']),
      action: AnalyticsAction.fromName(map['action']),
      timestamp: UtilFunctions.parseDateTime(map['timestamp']),
    );
  }
}
