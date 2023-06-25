part of 'todos_source_interface.dart';

class TodoSource with FirebaseErrorHandlerMixin implements TodoSourceInterface {
  final CollectionReference _tasks;
  final String _taskId;

  TodoSource({
    String? userId,
    required String taskId,
  })  : _taskId = taskId,
        _tasks = FirebaseFirestore.instance
            .collection(Keys.user)
            .doc(userId ?? UserManager().requireUser.uid)
            .collection(Keys.tasks);

  @override
  Future<void> addTodo(Todo todo) => handleError(_addTodo(todo));

  Future<void> _addTodo(Todo todo) async {
    await _tasks.doc(_taskId).update({
      Keys.todos: FieldValue.arrayUnion([todo.toMap()]),
    });
  }

  @override
  Future<void> deleteAllTodos() => handleError(_deleteAllTodos());

  Future<void> _deleteAllTodos() async {
    await _tasks.doc(_taskId).update({Keys.todos: FieldValue.delete()});
  }

  @override
  Future<void> deleteTodo(Todo todo) => handleError(_deleteTodo(todo));

  Future<void> searchForTodo(String query) async {
    _tasks.where('todos', arrayContains: 'query');
  }

  Future<void> _deleteTodo(Todo todo) async {
    await _tasks.doc(_taskId).update({
      Keys.todos: FieldValue.arrayRemove([todo.toMap()]),
    });
  }

  @override
  Future<List<Todo>> readTodos() => handleError(_readTodos());

  Future<List<Todo>> _readTodos() async {
    final QuerySnapshot snapshot =
        await _tasks.where(Keys.id, isEqualTo: _taskId).get();

    if (snapshot.docs.isEmpty) return [];

    final QueryDocumentSnapshot document = snapshot.docs.first;

    return (document.data() as Map)[Keys.todos]
            ?.map<Todo>((e) => Todo.fromMap((e as Map).cast()))
            .toList() ??
        [];
  }

  @override
  Future<void> updateTodos(List<Todo> todos) =>
      handleError(_updateTodos(todos));

  Future<void> _updateTodos(List<Todo> todos) async {
    await _tasks.doc(_taskId).update({
      Keys.todos: todos.map((e) => e.toMap()).toList(),
    });
  }
}
