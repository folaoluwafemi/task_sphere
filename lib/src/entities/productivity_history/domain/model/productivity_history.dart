import 'package:task_sphere/src/entities/productivity_history/domain/model/task_productivity_history.dart';

typedef ProductivityHistory = List<TaskProductivityHistory>;

extension ProductivityHistoryExtension on ProductivityHistory {
  List<Map<String, dynamic>> toSerializerList() {
    return map((e) => e.toMap()).toList();
  }
}
