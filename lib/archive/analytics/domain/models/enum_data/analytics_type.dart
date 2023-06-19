import 'package:task_sphere/src/utils/utils_barrel.dart';

enum AnalyticsDataType {
  user(),
  task(),
  todo();

  const AnalyticsDataType();

  factory AnalyticsDataType.fromName(String name) {
    name = name.cleanLower;
    return switch (name) {
      'task' => task,
      'todo' => todo,
      'user' => user,
      _ => throw UnsupportedError(
          'only Analytics for Task and Todo is supported',
        ),
    };
  }
}
