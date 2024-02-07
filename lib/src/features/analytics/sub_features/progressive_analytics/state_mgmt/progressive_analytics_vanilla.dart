import 'package:task_sphere/src/entities/productivity_history/productivity_history_barrel.dart';
import 'package:task_sphere/src/entities/task/task_barrel.dart';
import 'package:task_sphere/src/entities/todo/todo_barrel.dart';
import 'package:task_sphere/src/utils/utils_barrel.dart';
import 'package:vanilla_state/vanilla_state.dart';

part 'progressive_analytics_state.dart';

class ProgressiveAnalyticsVanilla
    extends VanillaNotifier<ProgressiveAnalysisState>
    with VanillaUtilsMixin<ProgressiveAnalysisState>, BasicErrorHandlerMixin {
  late final ProductivityHistoryManager _historyManager =
      ProductivityHistoryManager();
  late final TasksReader _tasksReader = TasksReader();

  ProgressiveAnalyticsVanilla()
      : super(
          ProgressiveAnalysisState(
            historySnapshots: ProductivityHistoryManager().snapshots.fold(
              [],
              _snapshotDateGrouper,
            ),
          ),
        ) {
    _historyManager.addListener(_historyListener);
    _tasksReader.addListener(_tasksListener);
  }

  void initialize() => handleSyncError(_initialize());

  Future<void> _initialize() async {
    await Future.delayed(const Duration(milliseconds: 1000));

    notifyLoading();
    await _historyManager.fetchHistory();
    notifySuccess();
  }

  Future<void> refresh() async {
    notifyLoading();
    await _historyManager.fetchHistory();
    notifySuccess();
  }

  void _updateStateFromHistory() {
    final List<ProductivitySnapshot> snapshots = _historyManager.snapshots;
    final List<ProductivitySnapshot> snapshotsGroupedByDay =
        snapshots.fold<List<ProductivitySnapshot>>([], _snapshotDateGrouper);

    state = state.copyWith(historySnapshots: snapshotsGroupedByDay);
  }

  void _historyListener() {
    _updateStateFromHistory();
  }

  void _tasksListener() {
    _updateTaskListState();
  }

  void _updateTaskListState() {
    state = state.copyWith(tasks: List.from(_tasksReader.tasks));
  }

  @override
  void dispose() {
    _tasksReader.removeListener(_tasksListener);
    _historyManager.removeListener(_historyListener);
    super.dispose();
  }

  static List<ProductivitySnapshot> _snapshotDateGrouper(
    List<ProductivitySnapshot> previousValue,
    ProductivitySnapshot element,
  ) {
    final int existingIndex = previousValue.indexWhere((p0) {
      return p0.dateTime.day == element.dateTime.day;
    });

    if (existingIndex != -1) {
      final ProductivitySnapshot snapshot = previousValue[existingIndex];
      return previousValue
        ..remove(snapshot)
        ..add(
          (
            dateTime: snapshot.dateTime,
            value: element.value + snapshot.value,
          ),
        );
    }
    return previousValue..add(element);
  }
}
