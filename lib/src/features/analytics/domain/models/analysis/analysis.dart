import 'package:task_sphere/src/features/analytics/domain/analytics_domain_barrel.dart';

typedef Analysis = List<Analytics>;

abstract final class AnalysisUtils {
  static Analysis fromSerializerList(List<Map<String, dynamic>> list) {
    return list.map((e) => Analytics.fromMap(e)).toList();
  }
}

extension AnalysisExtension on Analysis {
  List<Map<String, dynamic>> toSerializerList() {
    return map((e) => e.toMap()).toList();
  }

  Analysis get copy => List.from(this);
}
