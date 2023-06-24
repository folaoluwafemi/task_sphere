part of 'progressive_analytics_vanilla.dart';

class ProgressiveAnalysisState extends VanillaStateWithStatus {
  final List<ProductivitySnapshot> historySnapshots;
  final List<Task> tasks;

  const ProgressiveAnalysisState({
    required this.historySnapshots,
    this.tasks = const [],
    super.success = false,
    super.loading = false,
    super.error,
  });

  int get dailyStreak {
    return historySnapshots.length;
  }

  int get numberOfTodosDoneToday {
    return tasks.fold<List<Todo>>(
      [],
      (previousValue, element) => [
        ...previousValue,
        ...element.todos,
      ],
    ).where((todo) {
      return todo.isDone && todo.updatedAt.day == DateTime.now().day;
    }).length;
  }

  @override
  ProgressiveAnalysisState copyWith({
    List<ProductivitySnapshot>? historySnapshots,
    List<Task>? tasks,
    bool? success,
    bool? loading,
    Failure? error,
  }) {
    return ProgressiveAnalysisState(
      historySnapshots: historySnapshots ?? this.historySnapshots,
      tasks: tasks ?? this.tasks,
      success: success ?? this.success,
      loading: loading ?? this.loading,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
        historySnapshots,
        tasks,
        success,
        loading,
        error,
      ];
}
