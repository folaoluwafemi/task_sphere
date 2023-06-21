part of 'search_engine_interface.dart';

typedef TaskAndTodo = ({Task task, Todo todo});

class SearchEngine
    with BasicErrorHandlerMixin
    implements SearchEngineInterface {
  final TasksBufferInterface _taskBuffer;
  final _TasksFetcher _tasksFetcher;

  SearchEngine({
    TasksBufferInterface? taskBuffer,
  })  : _taskBuffer = taskBuffer ?? TasksBuffer(),
        _tasksFetcher = _TasksFetcher();

  List<SearchResult> searchDelegate({
    required List<Task> tasks,
    required String query,
    required SearchDateFilter? filter,
  }) {
    final List<TaskAndTodo> todos = tasks.fold(
      [],
      (previousValue, task) => [
        ...previousValue,
        ...task.todos.map((todo) => (task: task, todo: todo)),
      ],
    );

    final List<SearchResult> results = [
      ...searchForTodos(query, todos, filter),
      ...searchForTasks(query, tasks, filter),
    ];
    results.sort();
    return results;
  }

  List<SearchResult> searchForTodos(
    String query,
    List<TaskAndTodo> todos,
    SearchDateFilter? filter,
  ) {
    final List<SearchResult> results = [];

    for (final TaskAndTodo todoPair in todos) {
      if (filter?.startDate != null &&
          !todoPair.todo.updatedAt.isAfterOrAt(filter!.startDate)) {
        continue;
      }
      if (filter?.endDate != null &&
          !todoPair.todo.createdAt.isBeforeOrAt(filter!.endDate!)) {
        continue;
      }

      if (UtilFunctions.compareQueries(todoPair.todo.content, query)) {
        results.add(
          SearchResult(
            task: todoPair.task,
            value: todoPair.todo,
          ),
        );
      }
    }
    return results;
  }

  List<SearchResult> searchForTasks(
    String query,
    List<Task> tasks,
    SearchDateFilter? filter,
  ) {
    final List<SearchResult> results = [];

    for (final Task task in tasks) {
      if (filter?.startDate != null &&
          !task.updatedAt.isAfterOrAt(filter!.startDate)) {
        continue;
      }
      if (filter?.endDate != null &&
          !task.createdAt.isBeforeOrAt(filter!.endDate!)) {
        continue;
      }

      if (UtilFunctions.compareQueries(task.title, query) ||
          UtilFunctions.compareQueries(task.description, query)) {
        results.add(SearchResult(task: task));
      }
    }
    return results;
  }

  @override
  Future<List<SearchResult>> searchFor(
    String query, {
    SearchDateFilter? filter,
  }) =>
      handleError(_searchFor(query, filter: filter));

  Future<List<SearchResult>> _searchFor(
    String query, {
    SearchDateFilter? filter,
  }) async {
    final List<Task> tasks = await _tasksFetcher.fetchAllTasks();
    return searchDelegate(tasks: tasks, query: query, filter: filter);
  }

  @override
  List<SearchResult> searchSync(
    String query, {
    SearchDateFilter? filter,
  }) =>
      handleSyncError(_searchSync(query, filter: filter));

  List<SearchResult> _searchSync(
    String query, {
    SearchDateFilter? filter,
  }) {
    final List<Task> tasks = _taskBuffer.fetchTasks();
    return searchDelegate(tasks: tasks, query: query, filter: filter);
  }
}
