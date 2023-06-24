import 'package:task_sphere/src/entities/todo/todo_barrel.dart';
import 'package:task_sphere/src/utils/error_handling/data/failure.dart';

class TodoAnalyticsData {
  final TodoDescriptor type;
  final String value;

  const TodoAnalyticsData({
    required this.type,
    required this.value,
  });

  const TodoAnalyticsData.wholeTodo({
    required String id,
  })  : type = TodoDescriptor.all,
        value = id;

  String _getSerializerValue() {
    final dynamic data = type.dataFromValue(value);

    return switch (data) {
      final String temp => temp,
      final Enum temp => temp.name,
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
      type: TodoDescriptor.fromName(map['type'] as String),
      value: map['value'] as String,
    );
  }
}
