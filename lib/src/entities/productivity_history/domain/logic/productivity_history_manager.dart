part of 'productivity_history_manager_interface.dart';

class ProductivityHistoryManager extends VanillaNotifier<ProductivityHistory>
    implements ProductivityHistoryManagerInterface {
  final ProductivityHistorySourceInterface _source;

  ProductivityHistoryManager._({
    ProductivityHistorySourceInterface? source,
  })  : _source = source ?? ProductivityHistorySource(),
        super(ProductivityHistorySource().fetchAll());

  static final ProductivityHistoryManager instance =
      ProductivityHistoryManager._();

  factory ProductivityHistoryManager() => instance;

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
      _updateState();
      return;
    }

    taskHistory.snapshots.sort();

    final int productivityValue =
        task.productivityPoint - taskHistory.snapshots.last.value;

    await _source.addSnapshot(
      taskId: task.id,
      snapshot: (
        dateTime: task.updatedAt,
        value: productivityValue,
      ),
    );
    _updateState();
  }

  @override
  TaskProductivityHistory? fetchHistoryFor(String taskId) {
    _updateState();
    return _source.fetchHistoryFor(taskId);
  }

  @override
  List<ProductivitySnapshot> get snapshots => history.fold(
      [], (previousValue, element) => previousValue..addAll(element.snapshots))
    ..sort();

  void _updateState() {
    state = List.from(_source.fetchAll());
  }

  @override
  ProductivityHistory get history => List.from(state);

  @override
  Future<void> deleteHistoryFor(String taskId) async {
    await _source.removeHistoryFor(taskId);
    _updateState();
  }
}
