part of 'network_productivity_source.dart';

class FirebaseProductivityHistorySource
    with FirebaseErrorHandlerMixin
    implements NetworkProductivityHistorySourceInterface {
  final CollectionReference _history;

  FirebaseProductivityHistorySource({
    CollectionReference? history,
  }) : _history = history ??
            FirebaseFirestore.instance
                .collection(Keys.user)
                .doc(UserManager().requireUser.uid)
                .collection(Keys.productivityHistory);

  @override
  Future<void> addSnapshot({
    required String taskId,
    required ProductivitySnapshot snapshot,
  }) =>
      handleError(
        _addSnapshot(taskId: taskId, snapshot: snapshot),
      );

  Future<void> _addSnapshot({
    required String taskId,
    required ProductivitySnapshot snapshot,
  }) async {
    await _history
        .doc(taskId)
        .set(snapshot.toFirebaseMap(), SetOptions(merge: true));
  }

  @override
  Future<ProductivityHistory> fetchAll() => handleError(_fetchAll());

  Future<ProductivityHistory> _fetchAll() async {
    final QuerySnapshot snapshot = await _history.get();

    return _parseHistoryFrom(snapshot);
  }

  ProductivityHistory _parseHistoryFrom(QuerySnapshot snapshot) {
    final List<QueryDocumentSnapshot> data = snapshot.docs;

    if (data.isEmpty) return [];

    final ProductivityHistory history = [];

    for (final QueryDocumentSnapshot itemData in data) {
      final String taskId = itemData.id;

      final List<ProductivitySnapshot> snapshots = (itemData.data() as Map)
          .entries
          .map((e) => ProductivitySnapshotUtils.fromSnapshotMap(e))
          .toList();

      final TaskProductivityHistory taskHistory = TaskProductivityHistory(
        taskId: taskId,
        snapshots: snapshots,
      );
      history.add(taskHistory);
    }
    return history;
  }

  @override
  Future<TaskProductivityHistory?> fetchHistoryFor(String taskId) =>
      handleError(
        _fetchHistoryFor(taskId),
      );

  Future<TaskProductivityHistory?> _fetchHistoryFor(String taskId) async {
    final DocumentSnapshot snapshot = await _history.doc(taskId).get();

    if (!snapshot.exists) return null;

    final List<ProductivitySnapshot> snapshots = (snapshot.data() as Map)
        .entries
        .map((e) => ProductivitySnapshotUtils.fromSnapshotMap(e))
        .toList();

    return TaskProductivityHistory(
      taskId: taskId,
      snapshots: snapshots,
    );
  }

  @override
  Future<void> removeHistoryFor(String taskId) => handleError(
        _removeHistoryFor(taskId),
      );

  Future<void> _removeHistoryFor(String taskId) async {
    await _history.doc(taskId).delete();
  }

  @override
  Future<void> uploadHistory(ProductivityHistory history) async {
    final WriteBatch batch = FirebaseFirestore.instance.batch();
    for (final TaskProductivityHistory taskHistory in history) {
      batch.set(
        _history.doc(taskHistory.taskId),
        taskHistory.snapshots.toFirebaseList(),
      );
    }
    await batch.commit();
  }
}
