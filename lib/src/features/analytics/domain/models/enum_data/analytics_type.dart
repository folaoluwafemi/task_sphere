import 'package:task_sphere/src/utils/utils_barrel.dart';

enum AnalyticsDataType {
  task('task'),
  todo('todo');

  final String _data;

  const AnalyticsDataType(this._data);

  factory AnalyticsDataType.fromName(String name) {
    name = name.cleanLower;
    return switch (name) {
      'task' => task,
      'todo' => todo,
      _ => throw UnsupportedError(
          'only Analytics for Task and Todo is supported',
        ),
    };
  }
}
