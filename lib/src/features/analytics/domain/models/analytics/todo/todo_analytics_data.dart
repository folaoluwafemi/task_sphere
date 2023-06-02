import 'package:task_sphere/src/features/tasks_management/task_management_barrel.dart';
import 'package:task_sphere/src/utils/error_handling/data/failure.dart';

class TodoAnalyticsData {
  final TodoDescriptor type;
  final String value;

  const TodoAnalyticsData({
    required this.type,
    required this.value,
  });

  String _getSerializerValue() {
    final dynamic data = type.dataFromValue(value);

    return switch (data) {
      final String temp => temp,
      final Enum temp => temp.name,
      final DateTime temp => temp.toIso8601String(),
      _ => throw Failure(message: ErrorMessages.invalidType),
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'type': type.name,
      'value': _getSerializerValue(),
    };
  }

  factory TodoAnalyticsData.fromMap(Map<String, dynamic> map) {
    return TodoAnalyticsData(
      type: TodoDescriptor.fromName(map['type']),
      value: map['value'] as String,
    );
  }
}