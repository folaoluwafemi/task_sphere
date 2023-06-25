part of 'productivity_history_manager_interface.dart';

class ProductivityHistoryManager extends VanillaNotifier<ProductivityHistory>
    implements ProductivityHistoryManagerInterface {
  final NetworkProductivityHistorySourceInterface _source;

  ProductivityHistoryManager._({
    NetworkProductivityHistorySourceInterface? source,
  })  : _source = source ?? FirebaseProductivityHistorySource(),
        super([]) {
    UserManager().notifier.addListener(_reInitialize);
  }

  void _reInitialize() {
    if (UserManager().user == null) return;
    _instance = ProductivityHistoryManager._();
  }

  static ProductivityHistoryManager _instance = ProductivityHistoryManager._();

  factory ProductivityHistoryManager() => _instance;

  @override
  Future<void> fetchHistory() async {
    final ProductivityHistory history = await _source.fetchAll();
    _updateStateWith(history);
  }

  @override
  Future<void> pushSnapshotFrom(Task task) async {
    final TaskProductivityHistory taskHistory = state.firstWhere(
      (element) => element.taskId == task.id,
      orElse: () => TaskProductivityHistory(
        taskId: task.id,
        snapshots: [],
      ),
    );

    if (taskHistory.snapshots.isEmpty) {
      await _source.addSnapshot(
        taskId: task.id,
        snapshot: (
          dateTime: task.updatedAt,
          value: task.productivityPoint,
        ),
      );
      _updateStateWith(
        List.from(state)..addTaskHistory(taskHistory),
      );
      return;
    }

    taskHistory.snapshots.sort(ProductivitySnapshotUtils.compare);

    // important
    final int incoming = task.productivityPoint;
    final int current = taskHistory.snapshots.last.value;

    final int productivityValue = incoming > current ? incoming : -current;

    final ProductivitySnapshot snapshot = (
      dateTime: task.updatedAt,
      value: productivityValue,
    );

    await _source.addSnapshot(
      taskId: task.id,
      snapshot: snapshot,
    );
    _updateStateWith(
      ProductivityHistory.from(state)
        ..addTaskHistory(
          taskHistory.copyWith(
            snapshots: taskHistory.snapshots..add(snapshot),
          ),
        ),
    );
  }

  @override
  Future<TaskProductivityHistory?> fetchHistoryFor(String taskId) async {
    final TaskProductivityHistory? taskHistory = await _source.fetchHistoryFor(
      taskId,
    );
    if (taskHistory == null) return null;

    _updateStateWith(
      List.from(state)..addTaskHistory(taskHistory),
    );
    return taskHistory;
  }

  @override
  List<ProductivitySnapshot> get snapshots => currentHistory.fold(
        [],
        (previousValue, element) => previousValue..addAll(element.snapshots),
      )..sort(ProductivitySnapshotUtils.compare);

  void _updateStateWith(ProductivityHistory history) {
    state = List.from(history);
  }

  @override
  ProductivityHistory get currentHistory => List.from(state);

  @override
  Future<void> deleteHistoryFor(String taskId) async {
    await _source.removeHistoryFor(taskId);
    _updateStateWith(
      List.from(state)..removeWhere((element) => element.taskId == taskId),
    );
  }
}
