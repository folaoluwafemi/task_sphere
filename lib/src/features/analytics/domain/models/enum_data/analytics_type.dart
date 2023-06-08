import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_sphere/src/utils/utils_barrel.dart';

enum AnalyticsDataType {
  user('user'),
  task('task'),
  todo('todo');

  final String _data;

  const AnalyticsDataType(this._data);

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
