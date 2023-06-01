import 'package:task_sphere/src/utils/utils_barrel.dart';

abstract class VanillaStateWithStatus extends VanillaState {
  final bool success;
  final bool loading;
  final Failure? error;

  const VanillaStateWithStatus({
    required this.success,
    required this.loading,
    this.error,
  });

  dynamic copyWith({
    bool? success,
    bool? loading,
    Failure? error,
  });
}
