import 'package:task_sphere/archive/analytics/layers/domain/analytics_domain_barrel.dart';

abstract base class Analytics {
  final String id;
  final AnalyticsDataType type;
  final dynamic data;
  final AnalyticsAction action;
  final DateTime timestamp;

  const Analytics({
    required this.id,
    required this.type,
    required this.data,
    required this.action,
    required this.timestamp,
  });

  static Analytics fromMap(Map<String, dynamic> map) {
    final AnalyticsDataType type = AnalyticsDataType.fromName(map['type']);
    return switch (type) {
      AnalyticsDataType.task => TaskAnalytics.fromMap(map),
      AnalyticsDataType.todo => TodoAnalytics.fromMap(map),
      AnalyticsDataType.user => UserAnalytics.fromMap(map),
    };
  }

  Map<String, dynamic> toMap();
}
