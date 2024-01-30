part of 'tasks_repo_interface.dart';

class TasksRepository implements TasksRepoInterface {
  late final TasksReader _reader = TasksReader();
  late final ProductivityHistoryManager _historyManager =
      ProductivityHistoryManager();
  final TaskWriterInterface _tasksWriter;
  final TasksBufferInterface _buffer;

  TasksRepository({
    TaskWriterInterface? tasksWriter,
    TodoSourceInterface? todoSource,
    TasksBufferInterface? analysisManager,
  })  : _tasksWriter = tasksWriter ?? TaskWriter(),
        _buffer = analysisManager ?? TasksBuffer();

  @override
  Future<void> createTask(Task task) async {
    await performFirestoreTask(() async {
      _tasksWriter.createTask(task);

      _historyManager.pushSnapshotFrom(task);
    });

    await _buffer.addTask(task);

    await _reader.fetch(aFresh: true);
  }

  @override
  Future<void> deleteTask(String taskId) async {
    await performFirestoreTask(() async {
      _tasksWriter.deleteTask(taskId);

      _historyManager.deleteHistoryFor(taskId);
    });

    await _buffer.removeTask(taskId);

    await _reader.fetch(aFresh: true);
  }

  @override
  Future<void> deleteTodo(
    Todo todo, {
    required Task task,
  }) async {
    final TodoSource source = TodoSource(taskId: task.id);

    if (task.todos.contains(todo)) {
      task = task.copyWith(
        todos: task.todos.copy..remove(todo),
      );
    }

    performFirestoreTask(() async {
      source.deleteTodo(todo);

      _historyManager.pushSnapshotFrom(task);
    });

    await _buffer.updateTask(task);
  }

  @override
  Future<List<Todo>> readTodos({required String taskId}) async {
    final TodoSource source = TodoSource(taskId: taskId);

    return await source.readTodos();
  }

  @override
  Future<void> updateTask(
    Task task, {
    required bool shouldUpdateHistory,
  }) async {
    await performFirestoreTask(() async {
      _tasksWriter.updateTask(task);

      if (shouldUpdateHistory) _historyManager.pushSnapshotFrom(task);
    });

    await _buffer.updateTask(task);

    await _reader.fetch(aFresh: true);
  }

  @override
  Future<void> updateTodos(
    List<Todo> todos, {
    required bool shouldUpdateHistory,
    required Task task,
  }) async {
    final TodoSource source = TodoSource(taskId: task.id);

    task = task.copyWith(
      todos: task.todos.copy
        ..clear()
        ..addAll(todos),
    );
    await performFirestoreTask(() async {
      source.updateTodos(todos);

      if (shouldUpdateHistory) _historyManager.pushSnapshotFrom(task);
    });

    await _buffer.updateTask(task);

    await _reader.fetch(aFresh: true);
  }

  @override
  Future<void> deleteAllTodos(String taskId) async {
    final TodoSource source = TodoSource(taskId: taskId);

    await performFirestoreTask(() async {
      source.deleteAllTodos();

      _historyManager.deleteHistoryFor(taskId);
    });

    await _buffer.removeTask(taskId);

    await _reader.fetch(aFresh: true);
  }

  Future<void> performFirestoreTask(Future Function() computation) async {
    computation();
    await Future.delayed(const Duration(milliseconds: 800));
  }
}
