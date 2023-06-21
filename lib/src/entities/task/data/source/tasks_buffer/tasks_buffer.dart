part of 'tasks_buffer_interface.dart';

class TasksBuffer with BasicErrorHandlerMixin implements TasksBufferInterface {
  final Box<Map> _buffer;

  TasksBuffer({
    Box<Map>? buffer,
  }) : _buffer = buffer ?? Hive.box<Map>(StorageKeys.taskBuffer.box);

  @override
  Future<void> addTask(Task task) => handleError(_addTask(task));

  Future<void> _addTask(Task task) async {
    await _buffer.put(task.id, task.toMap());
  }

  @override
  List<Task> fetchTasks() => handleSyncError(_fetchTasks());

  List<Task> _fetchTasks() {
    final Iterable<Map> data = _buffer.values;
    if (data.isEmpty) return [];

    final List<Task> tasks = [];

    for (final Map map in data) {
      tasks.add(Task.fromMap(map.cast()));
    }
    return tasks;
  }

  @override
  Future<void> removeTask(String taskId) => handleError(_removeTask(taskId));

  Future<void> _removeTask(String taskId) async {
    await _buffer.delete(taskId);
  }

  @override
  Future<void> updateTask(Task task) => handleError(_updateTask(task));

  Future<void> _updateTask(Task task) async {
    if (_buffer.containsKey(task.id)) {
      await _removeTask(task.id);
    }

    await _buffer.put(task.id, task.toMap());
  }

  @override
  Future<void> clear() => handleError(_clear());

  Future<void> _clear() async {
    await _buffer.clear();
  }

  @override
  Future<void> addMultiple(List<Task> tasks) => handleError(
        _addMultiple(tasks),
      );

  Future<void> _addMultiple(List<Task> tasks) async {
    for (final Task task in tasks) {
      await _addTask(task);
    }
  }
}
