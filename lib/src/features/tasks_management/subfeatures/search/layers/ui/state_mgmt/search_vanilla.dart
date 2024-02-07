import 'package:task_sphere/src/features/tasks_management/task_management_barrel.dart';
import 'package:task_sphere/src/utils/utils_barrel.dart';
import 'package:vanilla_state/vanilla_state.dart';

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

  void _initialize() {
    _historyManager.addListener(_searchHistoryListener);
    state = state.copyWith(
      allResults: _searchEngine.searchSync(''),
    );
  }

  void changeSearchFilterTo(SearchFilter filter) {
    final SearchState newState = state.copyWithAsNull(
      filter: filter,
      dateFilter: null,
    );

    state = newState.copyWith(
      currentResults: newState.applyFilterTo(state.allResults),
    );
  }

  void changeDateFilter(
    SearchDateFilter filter, {
    bool setToNull = false,
  }) {
    final SearchState newState = state.copyWithAsNull(
      dateFilter: setToNull ? null : filter,
    );
    state = newState.copyWith(
      currentResults: newState.applyFilterTo(state.allResults),
    );
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
      currentResults: state.applyFilterTo(results),
    );
  }

  void maybeSearch(String query) {
    if (state.currentResults.isNotEmpty) return;
    searchQuick(query);
  }

  void clearQuery() {
    final SearchState newState = state.copyWithAsNull(
      query: '',
      dateFilter: null,
      filter: SearchFilter.all,
    );

    state = newState.copyWith(
      currentResults: newState.applyFilterTo(state.allResults),
    );
  }

  void clearFilters() {
    final SearchState newState = state.copyWithAsNull(
      dateFilter: null,
      filter: SearchFilter.all,
    );

    state = newState.copyWith(
      currentResults: newState.applyFilterTo(state.allResults),
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
    if (query.isEmpty) return searchQuick(query);

    notifyLoading(state_: state.copyWith(query: query));

    final List<SearchResult> results = await _searchEngine.searchFor(
      query,
      filter: state.dateFilter,
    );

    await _historyManager.addSearchQuery(query);

    notifySuccess(
      state: state.copyWith(
        currentResults: state.applyFilterTo(results),
      ),
    );
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
