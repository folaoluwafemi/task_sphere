part of 'search_history_manager_interface.dart';

class SearchHistoryManager extends VanillaNotifier<List<String>>
    implements SearchHistoryManagerInterface {
  final SearchHistorySourceInterface _source;

  SearchHistoryManager._({
    SearchHistorySourceInterface? source,
  })  : _source = source ?? SearchHistorySource(),
        super(SearchHistorySource().fetchSearchQueries());

  static final SearchHistoryManager instance = SearchHistoryManager._();

  factory SearchHistoryManager() => instance;

  @override
  List<String> get currentHistory => List.from(state);

  void updateState() {
    state = _source.fetchSearchQueries();
  }

  @override
  Future<void> addSearchQuery(String query) async {
    await _source.addSearchQuery(query);
    updateState();
  }

  @override
  List<String> fetchSearchQueries() {
    updateState();
    return _source.fetchSearchQueries();
  }

  @override
  Future<void> clearHistory() async {
    await _source.clearHistory();
    updateState();
  }
}
