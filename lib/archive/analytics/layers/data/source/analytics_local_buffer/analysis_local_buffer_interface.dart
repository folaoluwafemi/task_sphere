import 'package:hive_flutter/hive_flutter.dart';
import 'package:task_sphere/archive/analytics/layers/domain/analytics_domain_barrel.dart';
import 'package:task_sphere/src/utils/utils_barrel.dart';

part 'analysis_local_buffer.dart';

abstract interface class AnalyticsLocalBufferInterface {
  Future<void> saveAnalysis(Analysis analysis);

  Future<void> push(Analytics analytics);

  Analysis getAnalysis();

  Future<void> clearBuffer();
}
