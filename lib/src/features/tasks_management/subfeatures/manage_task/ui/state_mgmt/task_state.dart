part of 'task_vanilla.dart';

class TaskState extends VanillaStateWithStatus {
  final bool isNew;
  final Task task;
  final String? loadingText;
  final bool showAchievement;

  TaskState({
    super.success = false,
    super.loading = false,
    super.error,
    required Task? task,
    this.loadingText,
    this.showAchievement = false,
  })  : isNew = task == null,
        task = task ?? Task.empty();

  TaskState withTask(Task task) => copyWith(
        task: task,
      );

  @override
  TaskState copyWith({
    bool? success,
    bool? loading,
    bool? showAchievement,
    Failure? error,
    Task? task,
    String? loadingText,
  }) {
    if (task != null) {
      task = task.copyWith(
        todos: task.todos
          ..clearDuplicatesWhere(
            (element1, element2) => element1.id == element2.id,
          ),
      );
    }

    return TaskState(
      showAchievement: showAchievement ?? this.showAchievement,
      task: task ?? this.task,
      success: success ?? this.success,
      loading: loading ?? this.loading,
      error: error,
      loadingText: loadingText,
    );
  }

  @override
  List<Object?> get props => [
        task,
        isNew,
        success,
        loading,
        error,
        loadingText,
        showAchievement,
      ];
}
