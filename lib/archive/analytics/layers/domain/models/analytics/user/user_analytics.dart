import 'package:task_sphere/archive/analytics/layers/domain/analytics_domain_barrel.dart';
import 'package:task_sphere/src/utils/functions/util_functions.dart';

final class UserAnalytics extends Analytics {
  final String userId;

  const UserAnalytics({
    required super.id,
    required this.userId,
    required super.action,
    required super.timestamp,
  }) : super(
          type: AnalyticsDataType.user,
          data: userId,
        );

  UserAnalytics.create({
    required this.userId,
    required super.action,
  }) : super(
          id: UtilFunctions.generateId(),
          type: AnalyticsDataType.user,
          data: userId,
          timestamp: DateTime.now(),
        );

  static UserAnalytics fromMap(Map<String, dynamic> map) {
    return UserAnalytics(
      id: map['id'],
      userId: map['data'],
      action: AnalyticsAction.fromName(map['action']),
      timestamp: UtilFunctions.parseDateTime(map['timestamp']),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type.name,
      'data': userId,
      'action': action.name,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}
