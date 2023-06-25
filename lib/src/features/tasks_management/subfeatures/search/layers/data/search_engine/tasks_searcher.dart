part of 'search_engine_interface.dart';

class _TasksFetcher with FirebaseErrorHandlerMixin {
  final CollectionReference _tasksRef;

  _TasksFetcher()
      : _tasksRef = FirebaseFirestore.instance
            .collection(Keys.user)
            .doc(UserManager().requireUser.uid)
            .collection(Keys.tasks);

  Future<List<Task>> fetchAllTasks() => handleError(_fetchAllTasks());

  Future<List<Task>> _fetchAllTasks() async {
    final QuerySnapshot snapshot = await _tasksRef.get();

    return snapshot.docs
        .map((doc) => Task.fromMap((doc.data() as Map).cast()))
        .toList();
  }
}
