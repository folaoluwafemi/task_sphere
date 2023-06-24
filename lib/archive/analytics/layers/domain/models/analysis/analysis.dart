import 'package:task_sphere/archive/analytics/layers/domain/analytics_domain_barrel.dart';

typedef Analysis = List<Analytics>;

abstract final class AnalysisUtils {
  static Analysis fromSerializerList(List<Map> list) {
    final Analysis analysis = list.map((map) {
      return Analytics.fromMap(map.cast<String, dynamic>());
    }).toList();
    return analysis;
  }
}

extension AnalysisExtension on Analysis {
  List<Map<String, dynamic>> toSerializerList() {
    return map((e) => e.toMap()).toList();
  }

  Analysis get copy => List.from(this);
}
