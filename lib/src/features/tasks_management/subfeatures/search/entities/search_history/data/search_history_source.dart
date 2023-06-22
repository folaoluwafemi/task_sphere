part of 'search_history_source_interface.dart';

typedef QueryWithTimestamp = ({
  String query,
  DateTime timestamp,
});

class SearchHistorySource
    with BasicErrorHandlerMixin
    implements SearchHistorySourceInterface {
  final Box<String> _box;

  SearchHistorySource({
    Box<String>? box,
  }) : _box = box ?? Hive.box<String>(StorageKeys.searchHistory.box);

  @override
  Future<void> addSearchQuery(String query) => handleError(
        _addSearchQuery(query),
      );

  Future<void> _addSearchQuery(String query) async {
    final DateTime timestamp = DateTime.now();

    final List<QueryWithTimestamp> currentList =
        _fetchSearchQueryWithTimeStamp();

    currentList.sort(_listSorter);

    if (currentList.length >= 7) {
      final List<QueryWithTimestamp> temp = currentList.copy;
      currentList.removeWhere((element) => temp.indexOf(element) >= 6);
    }
    currentList.add(
      (
        timestamp: timestamp,
        query: query,
      ),
    );

    await clearHistory();

    for (final QueryWithTimestamp data in currentList) {
      await _box.put(
        data.timestamp.toIso8601String(),
        data.query,
      );
    }
  }

  @override
  List<String> fetchSearchQueries() => handleSyncError(
        _fetchSearchQueries(),
      );

  List<String> _fetchSearchQueries() {
    final List<QueryWithTimestamp> data = _fetchSearchQueryWithTimeStamp();
    data.sort(_listSorter);

    return data.map((e) => e.query).toList().cast();
  }

  @override
  List<QueryWithTimestamp> fetchSearchQueryWithTimeStamp() => handleSyncError(
        _fetchSearchQueryWithTimeStamp(),
      );

  List<QueryWithTimestamp> _fetchSearchQueryWithTimeStamp() {
    final List<DateTime> keys =
        _box.keys.map((e) => DateTime.parse(e as String)).toList().cast();
    final List<QueryWithTimestamp> data = [];

    for (final DateTime key in keys) {
      data.add(
        (
          timestamp: key,
          query: _box.get(key.toIso8601String())!,
        ),
      );
    }

    return data;
  }

  int _listSorter(
    QueryWithTimestamp a,
    QueryWithTimestamp b,
  ) {
    return b.timestamp.compareTo(a.timestamp);
  }

  @override
  Future<void> clearHistory() => handleError(_clearHistory());

  Future<void> _clearHistory() async {
    await _box.clear();
  }
}
