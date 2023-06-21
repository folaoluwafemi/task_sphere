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

    for (final QueryWithTimestamp data in currentList) {
      await _box.put(data.timestamp, data.query);
    }
  }

  @override
  List<String> fetchSearchQueries() => handleSyncError(
        _fetchSearchQueries(),
      );

  List<String> _fetchSearchQueries() {
    final List<String> data = _box.values.toList();
    return data;
  }

  @override
  List<QueryWithTimestamp> fetchSearchQueryWithTimeStamp() => handleSyncError(
        _fetchSearchQueryWithTimeStamp(),
      );

  List<QueryWithTimestamp> _fetchSearchQueryWithTimeStamp() {
    final List<DateTime> keys = _box.keys.toList().cast();
    final List<QueryWithTimestamp> data = [];

    for (final DateTime key in keys) {
      data.add(
        (
          timestamp: key,
          query: _box.get(key)!,
        ),
      );
    }

    return data;
  }

  int _listSorter(
    QueryWithTimestamp a,
    QueryWithTimestamp b,
  ) {
    return a.timestamp.compareTo(b.timestamp);
  }
}
