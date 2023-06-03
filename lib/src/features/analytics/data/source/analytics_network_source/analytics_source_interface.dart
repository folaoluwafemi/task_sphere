import 'package:task_sphere/src/features/analytics/domain/analytics_domain_barrel.dart';

abstract interface class AnalyticsSourceInterface {
  Future<void> createUserAnalyticsBucket(String userId);

  Future<void> uploadAnalysis(Analysis analysis);

  Future<Analysis> fetchAnalysis(Analysis analysis);
}
