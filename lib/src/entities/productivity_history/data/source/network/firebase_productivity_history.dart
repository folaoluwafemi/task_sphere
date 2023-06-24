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
                .doc(UserManager.requireUser.uid)
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
    // when adding a snapshot to a task, the overall amount of tasks must be at most 7
    // if it's more than 7, then we need to remove the oldest snapshot

    await FirebaseFirestore.instance.runTransaction(
      (transaction) => _transactionHandler(
        transaction,
        taskId: taskId,
        snapshot: snapshot,
      ),
    );
  }

  Future _transactionHandler(
    Transaction transaction, {
    required String taskId,
    required ProductivitySnapshot snapshot,
  }) async {
    final DocumentSnapshot historySnapshot = await transaction.get(
      _history.doc(taskId),
    );

    if (!historySnapshot.exists || historySnapshot.data() == null) {
      final TaskProductivityHistory history = TaskProductivityHistory(
        taskId: taskId,
        snapshots: [snapshot],
      );

      transaction = transaction.set(
        _history.doc(taskId),
        history.snapshots.toFirebaseList(),
      );
      return transaction;
    }

    final List<ProductivitySnapshot> snapshots = (historySnapshot.data() as Map)
        .entries
        .map((e) => ProductivitySnapshotUtils.fromSnapshotMap(e))
        .toList();

    if (snapshots.length >= 7) {
      final ProductivitySnapshot oldestSnapshot = snapshots.first;

      transaction = transaction.update(
        _history.doc(taskId),
        {oldestSnapshot.dateTime.toIso8601String(): FieldValue.delete()},
      );
    }

    final TaskProductivityHistory history = TaskProductivityHistory(
      taskId: taskId,
      snapshots: snapshots..add(snapshot),
    );

    transaction = transaction.set(
      _history.doc(taskId),
      history.snapshots.toFirebaseList(),
    );
    return transaction;
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
