import 'package:task_sphere/src/features/tasks_management/task_management_barrel.dart';
import 'package:task_sphere/src/utils/utils_barrel.dart';

part 'search_state.dart';

class SearchVanilla extends VanillaNotifier<SearchState>
    with VanillaUtilsMixin, BasicErrorHandlerMixin {
  late final SearchHistoryManager _historyManager = SearchHistoryManager();
  final SearchEngineInterface _searchEngine;

  SearchVanilla({
    SearchEngineInterface? searchEngine,
  })  : _searchEngine = searchEngine ?? SearchEngine(),
        super(
          SearchState(
            history: SearchHistoryManager().fetchSearchQueries(),
          ),
        );

  void initialize() => handleSyncError(
        _initialize(),
        catcher: notifyOnError,
      );

  void _initialize() => _historyManager.addListener(_searchHistoryListener);

  void changeSearchFilterTo(SearchFilter filter) {
    state = state.copyWith(filter: filter);
  }

  void changeDateFilter({
    DateTime? startDate,
    DateTime? endDate,
    bool disable = false,
  }) =>
      handleSyncError(
        _changeDateFilter(
          startDate: startDate,
          endDate: endDate,
          setToNull: disable,
        ),
      );

  void _changeDateFilter({
    DateTime? startDate,
    DateTime? endDate,
    required bool setToNull,
  }) {
    if (setToNull) {
      state = state.copyWith(dateFilter: null);
      return;
    }
    if (startDate != null) state = state.updateStartDateFilter(startDate);
    if (endDate != null) state = state.updateEndDateFilter(endDate);
  }

  void searchQuick(String query) => handleSyncError(
        _searchQuick(query),
        catcher: notifyOnError,
      );

  void _searchQuick(String query) {
    final List<SearchResult> results = _searchEngine.searchSync(
      query,
      filter: state.dateFilter,
    );

    state = state.copyWith(
      query: query,
      currentResults: state.filter.applyTo(results),
    );
  }

  void clearQuery() {
    state = state.copyWith(
      query: '',
      currentResults: state.filter.applyTo(state.allResults),
    );
  }

  Future<void> clearHistory() => handleError(
        _clearHistory(),
        catcher: notifyOnError,
      );

  Future<void> _clearHistory() async {
    await _historyManager.clearHistory();
  }

  Future<void> searchFor(String query) => handleError(
        _searchFor(query),
        catcher: notifyOnError,
      );

  Future<void> _searchFor(String query) async {
    notifyLoading(state_: state.copyWith(query: query));

    final List<SearchResult> results = await _searchEngine.searchFor(
      query,
      filter: state.dateFilter,
    );

    await _historyManager.addSearchQuery(query);

    notifySuccess(
      state: state.copyWith(
        currentResults: state.filter.applyTo(results),
      ),
    );
  }

  void setInitialDateFilter(DateTime startDate) {
    state = state.updateStartDateFilter(startDate);
  }

  void _searchHistoryListener() {
    state = state.copyWith(
      history: _historyManager.currentHistory.copy,
    );
  }

  @override
  void dispose() {
    _historyManager.removeListener(_searchHistoryListener);
    super.dispose();
  }
}
