import 'package:task_sphere/src/entities/task/task_barrel.dart';
import 'package:task_sphere/src/utils/utils_barrel.dart';
import 'package:vanilla_state/vanilla_state.dart';

part 'home_state.dart';

class HomeVanilla extends VanillaNotifier<HomeState>
    with BasicErrorHandlerMixin, VanillaUtilsMixin {
  late final TasksReader _taskReader = TasksReader();

  HomeVanilla()
      : super(
          const HomeState(
            allTasks: [],
            currentTasks: [],
          ),
        );

  Future<void> initialize() => handleError(_initialize());

  Future<void> _initialize() async {
    notifyLoading();
    final List<Task> initialTasks = await _taskReader.fetch(aFresh: true);
    notifySuccess(
      state: state.copyWith(
        hasReachedLimit: false,
        allTasks: initialTasks,
        currentTasks: state.filter.filterTasks(initialTasks),
      ),
    );
    _taskReader.addListener(_tasksListener);
  }

  Future<void> fetchTasks() => handleError(_fetchTasks());

  Future<void> _fetchTasks() async {
    notifyLoading();
    await _taskReader.fetch(more: true);
    notifySuccess();
  }

  Future<void> refresh() => handleError(_refresh());

  Future<void> _refresh() async {
    state = state.copyWith(allTasks: [], currentTasks: [], loading: true);
    await _taskReader.fetch(aFresh: true);
    notifySuccess();
  }

  void setFilter(TasksFilter filter) {
    state = state.copyWith(
      filter: filter,
      currentTasks: filter.filterTasks(state.allTasks),
    );
  }

  void _tasksListener() {
    state = state.copyWith(
      hasReachedLimit: _taskReader.tasks.length == state.allTasks.length,
      allTasks: List.from(_taskReader.tasks),
      currentTasks: state.filter.filterTasks(_taskReader.tasks),
    );
  }

  @override
  void dispose() {
    _taskReader.removeListener(_tasksListener);
    super.dispose();
  }
}
