import 'package:task_sphere/src/entities/apis/firebase/firebase_api_barrel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_sphere/archive/analytics/layers/domain/analytics_domain_barrel.dart';

import 'package:task_sphere/src/entities/user/user_barrel.dart';
import 'package:task_sphere/src/utils/utils_barrel.dart';

part 'firebase_analysis_source.dart';

abstract interface class AnalysisSourceInterface {
  Future<void> createUserAnalyticsBucket(String userId);

  Future<void> uploadAnalysis(Analysis analysis);

  Future<Analysis> fetchAnalysis(Analysis analysis);
}
