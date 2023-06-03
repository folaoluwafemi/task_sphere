import 'package:task_sphere/src/features/analytics/domain/analytics_domain_barrel.dart';

abstract interface class AnalyticsLocalBufferInterface {
  Future<void> saveAnalysis(Analysis analysis);

  Future<void> pushAnalytics(Analytics analytics);

  Analysis getAnalysis();

  Future<void> clearBuffer();
}
