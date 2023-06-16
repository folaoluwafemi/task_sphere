part of 'task_vanilla.dart';

class TaskState extends VanillaStateWithStatus {
  final bool isNew;
  final Task task;

  TaskState({
    super.success = false,
    super.loading = false,
    super.error,
    required Task? task,
  })  : isNew = task == null,
        task = task ?? Task.empty();

  @override
  TaskState copyWith({
    bool? success,
    bool? loading,
    Failure? error,
    Task? task,
  }) {
    return TaskState(
      task: task ?? this.task,
      success: success ?? this.success,
      loading: loading ?? this.loading,
      error: error,
    );
  }

  @override
  List<Object?> get props => [task, isNew, success, loading, error];
}
