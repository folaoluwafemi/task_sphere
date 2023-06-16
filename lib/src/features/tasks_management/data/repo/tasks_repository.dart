part of 'tasks_repo_interface.dart';

class TasksRepository implements TasksRepoInterface {
  late final TasksReader _reader = TasksReader();
  final TaskWriterInterface _tasksWriter;
  final AnalyticsLocalBufferInterface _analyticsLocalBuffer;

  TasksRepository({
    TaskWriterInterface? tasksWriter,
    TodoSourceInterface? todoSource,
    AnalyticsLocalBufferInterface? analyticsLocalBuffer,
  })  : _tasksWriter = tasksWriter ?? TaskWriter(),
        _analyticsLocalBuffer = analyticsLocalBuffer ?? AnalysisLocalBuffer();

  @override
  Future<void> addTodo(
    Todo todo, {
    required String taskId,
  }) async {
    final TodoSource source = TodoSource(taskId: taskId);

    await source.addTodo(todo);

    final TodoAnalytics analytics = TodoAnalytics.create(
      analyticsData: TodoAnalyticsData.wholeTodo(id: todo.id),
      action: AnalyticsAction.create,
    );

    await _analyticsLocalBuffer.push(analytics);
  }

  @override
  Future<void> createTask(Task task) async {
    await _tasksWriter.createTask(task);

    final TaskAnalytics analytics = TaskAnalytics.create(
      taskId: task.id,
      action: AnalyticsAction.create,
    );

    await _analyticsLocalBuffer.push(analytics);
  }

  @override
  Future<void> deleteTask(String taskId) async {
    await _tasksWriter.deleteTask(taskId);

    final TaskAnalytics analytics = TaskAnalytics.create(
      taskId: taskId,
      action: AnalyticsAction.delete,
    );

    await _analyticsLocalBuffer.push(analytics);

    await _reader.fetch(aFresh: true);
  }

  @override
  Future<void> deleteTodo(
    Todo todo, {
    required String taskId,
  }) async {
    final TodoSource source = TodoSource(taskId: taskId);

    await source.deleteTodo(todo);

    final TodoAnalytics analytics = TodoAnalytics.create(
      analyticsData: TodoAnalyticsData.wholeTodo(id: todo.id),
      action: AnalyticsAction.delete,
    );

    await _analyticsLocalBuffer.push(analytics);
  }

  @override
  Future<List<Todo>> readTodos({required String taskId}) async {
    final TodoSource source = TodoSource(taskId: taskId);

    return await source.readTodos();
  }

  @override
  Future<void> updateTask(Task task) async {
    await _tasksWriter.updateTask(task);

    final TaskAnalytics analytics = TaskAnalytics.create(
      taskId: task.id,
      action: AnalyticsAction.update,
    );

    await _analyticsLocalBuffer.push(analytics);

    await _reader.fetch(aFresh: true);
  }

  @override
  Future<void> updateTodos(
    List<Todo> todos, {
    required String taskId,
  }) async {
    final TodoSource source = TodoSource(taskId: taskId);

    await source.updateTodos(todos);

    final TaskAnalytics analytics = TaskAnalytics.create(
      taskId: taskId,
      action: AnalyticsAction.update,
    );

    await _analyticsLocalBuffer.push(analytics);

    await _reader.fetch(aFresh: true);
  }
}
