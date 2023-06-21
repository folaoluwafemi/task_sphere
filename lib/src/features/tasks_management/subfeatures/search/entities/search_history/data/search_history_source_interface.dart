import 'package:hive_flutter/hive_flutter.dart';
import 'package:task_sphere/src/utils/utils_barrel.dart';

part 'search_history_source.dart';

abstract interface class SearchHistorySourceInterface {
  Future<void> addSearchQuery(String query);

  Future<void> clearHistory();

  List<String> fetchSearchQueries();

  List<QueryWithTimestamp> fetchSearchQueryWithTimeStamp();
}
