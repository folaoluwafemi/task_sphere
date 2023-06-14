import 'package:task_sphere/src/features/tasks_management/task_management_barrel.dart';
import 'package:task_sphere/src/utils/utils_barrel.dart';

part 'home_state.dart';

class HomeVanilla extends VanillaNotifier<HomeState>
    with BasicErrorHandlerMixin, VanillaUtilsMixin {
  late final TasksReader _taskReader = TasksReader();

  HomeVanilla()
      : super(const HomeState(
          allTasks: [],
          currentTasks: [],
        ));

  Future<void> initialize() => handleError(_initialize());

  Future<void> _initialize() async {
    notifyLoading();
    final List<Task> initialTasks = await _taskReader.fetch(aFresh: true);
    notifySuccess(
        state: state.copyWith(
      allTasks: initialTasks,
      currentTasks: state.filter.filterTasks(initialTasks),
    ));
    _taskReader.addListener(_tasksListener);
  }

  Future<void> fetchTasks(Task task) => handleError(_fetchTasks(task));

  Future<void> _fetchTasks(Task task) async {
    await _taskReader.fetch(more: true);
  }

  Future<void> refresh() => handleError(_refresh());

  Future<void> _refresh() async {
    await _taskReader.fetch(aFresh: true);
  }

  void setFilter(TasksFilter filter) {
    state = state.copyWith(
      filter: filter,
      currentTasks: filter.filterTasks(state.allTasks),
    );
  }

  void _tasksListener() {
    state = state.copyWith(
      allTasks: _taskReader.tasks,
      currentTasks: state.filter.filterTasks(_taskReader.tasks),
    );
  }

  @override
  void dispose() {
    _taskReader.removeListener(_tasksListener);
    super.dispose();
  }
}
