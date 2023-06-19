part of 'task_writer_interface.dart';

class TaskWriter with FirebaseErrorHandlerMixin implements TaskWriterInterface {
  final CollectionReference _tasks;

  TaskWriter({String? userId})
      : _tasks = FirebaseFirestore.instance
            .collection(Keys.user)
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
  Future<void> updateTask(Task task) => handleError(_updateTask(task));

  Future<void> _updateTask(Task task) async {
    await _tasks.doc(task.id).update(task.toMap());
  }
}
