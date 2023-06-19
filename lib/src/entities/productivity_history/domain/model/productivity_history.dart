import 'package:task_sphere/src/entities/productivity_history/productivity_history_barrel.dart';

typedef ProductivityHistory = List<TaskProductivityHistory>;

extension ProductivityHistoryExtension on ProductivityHistory {
  List<Map<String, dynamic>> toSerializerList() {
    return map((e) => e.toMap()).toList();
  }
}
