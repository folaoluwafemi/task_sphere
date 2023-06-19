part of 'productivity_history_source_interface.dart';

class ProductivityHistorySource
    with BasicErrorHandlerMixin
    implements ProductivityHistorySourceInterface {
  final Box<List> _box;

  ProductivityHistorySource({
    Box<List>? box,
  }) : _box = box ?? Hive.box(StorageKeys.history.box);

  @override
  Future<void> addSnapshot({
    required String taskId,
    required ProductivitySnapshot snapshot,
  }) =>
      handleError(_addSnapshot(taskId: taskId, snapshot: snapshot));

  Future<void> _addSnapshot({
    required String taskId,
    required ProductivitySnapshot snapshot,
  }) async {
    _box.keys;
    _box.values;

    TaskProductivityHistory? history = _fetchHistoryFor(taskId);

    if (history == null) return await _createNewHistoryWith(taskId, snapshot);

    history = history.withSnapshots(
      history.snapshots.copy..add(snapshot),
    );

    _box.put(taskId, history.snapshots.toSerializerList());
  }

  Future<void> _createNewHistoryWith(
    String taskId,
    ProductivitySnapshot snapshot,
  ) async {
    _box.put(taskId, [snapshot.toMap()]);
  }

  @override
  TaskProductivityHistory? fetchHistoryFor(String taskId) => handleSyncError(
        _fetchHistoryFor(taskId),
      );

  TaskProductivityHistory? _fetchHistoryFor(String taskId) {
    List? data = _box.get(taskId);

    if (data == null) return null;

    return TaskProductivityHistory(
      taskId: taskId,
      snapshots: data.map((e) => ProductivitySnapshotUtils.fromMap(e)).toList(),
    );
  }

  @override
  ProductivityHistory fetchAll() => handleSyncError(_fetchAll());

  ProductivityHistory _fetchAll() {
    final List<String> keys = _box.keys.toList().cast();

    final List<NamedPair<String, List>> raw = [];

    for (final String key in keys) {
      raw.add((first: key, second: _box.get(key) ?? []));
    }

    final ProductivityHistory history = [];

    for (final NamedPair<String, List> pair in raw) {
      history.add(
        TaskProductivityHistory(
          taskId: pair.first,
          snapshots: pair.second
              .map((e) => ProductivitySnapshotUtils.fromMap(e))
              .toList(),
        ),
      );
    }

    return history;
  }
}
