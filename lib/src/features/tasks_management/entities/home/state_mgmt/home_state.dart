part of 'home_vanilla.dart';

enum TasksFilter {
  all,
  todo,
  completed;

  List<Task> filterTasks(List<Task> tasks) => List.from(
        tasks.where((element) {
          return switch (this) {
            all => true,
            todo => element.isTodo,
            completed => element.isCompleted,
          };
        }).toList(),
      );

  int count(List<Task> tasks) => switch (this) {
        all => tasks.length,
        todo => tasks.where((element) => element.isTodo).length,
        completed => tasks.where((element) => element.isCompleted).length,
      };
}

class HomeState extends VanillaStateWithStatus {
  final List<Task> allTasks;
  final List<Task> currentTasks;
  final TasksFilter filter;
  final bool hasReachedLimit;

  const HomeState({
    required this.allTasks,
    required this.currentTasks,
    this.filter = TasksFilter.all,
    this.hasReachedLimit = false,
    super.success = false,
    super.loading = false,
    super.error,
  });

  int get completedLength => allTasks.where((element) {
        return element.isCompleted;
      }).length;

  int get todoLength => allTasks.where((element) => element.isTodo).length;

  @override
  HomeState copyWith({
    List<Task>? allTasks,
    List<Task>? currentTasks,
    TasksFilter? filter,
    bool? hasReachedLimit,
    bool? success,
    bool? loading,
    Failure? error,
  }) {
    return HomeState(
      allTasks: allTasks ?? this.allTasks,
      currentTasks: currentTasks ?? this.currentTasks,
      filter: filter ?? this.filter,
      hasReachedLimit: hasReachedLimit ?? this.hasReachedLimit,
      success: success ?? this.success,
      loading: loading ?? this.loading,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
        allTasks,
        currentTasks,
        filter,
        hasReachedLimit,
        success,
        loading,
        error,
      ];
}
