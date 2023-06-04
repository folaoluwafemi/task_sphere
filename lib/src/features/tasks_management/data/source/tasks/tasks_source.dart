part of 'task_management_source_interface.dart';

class TaskSource with FirebaseErrorHandlerMixin implements TaskSourceInterface {
  final CollectionReference _tasks;

  TaskSource({
    required String? userId,
  }) : _tasks = FirebaseFirestore.instance
            .collection(Keys.users)
            .doc(userId ?? UserManager.requireUser.uid)
            .collection(Keys.tasks);

  @override
  Future<void> createTask(Task task) => handleError(_createTask(task));

  Future<void> _createTask(Task task) async {
    await _tasks.doc(task.id).set(task.toMap());
  }

  @override
  Future<void> deleteTask(String taskId) => handleError(_deleteTask(taskId));

  Future<void> _deleteTask(String taskId) async {
    await _tasks.doc(taskId).delete();
  }

  @override
  Future<List<Task>> readTasks() => handleError(_readTasks());

  Future<List<Task>> _readTasks() async {
    final QuerySnapshot snapshot = await _tasks.get();
    return snapshot.docs
        .map((e) => Task.fromMap((e.data() as Map).cast()))
        .toList();
  }

  @override
  Future<void> updateTask(Task task) => handleError(_updateTask(task));

  Future<void> _updateTask(Task task) async {
    await _tasks.doc(task.id).update(task.toMap());
  }
}
