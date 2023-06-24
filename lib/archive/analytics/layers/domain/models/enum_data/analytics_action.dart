import 'package:task_sphere/src/utils/utils_barrel.dart';

enum AnalyticsAction {
  create,
  update,
  delete;

  factory AnalyticsAction.fromName(String name) {
    name = name.cleanLower;
    return switch (name) {
      'create' => create,
      'update' => update,
      'delete' => delete,
      _ => throw UnsupportedError('$name is not supported'),
    };
  }
}
