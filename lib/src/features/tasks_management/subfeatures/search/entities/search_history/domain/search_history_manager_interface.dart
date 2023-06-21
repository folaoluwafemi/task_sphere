import 'package:task_sphere/src/features/tasks_management/subfeatures/search/entities/search_history/data/search_history_source_interface.dart';
import 'package:task_sphere/src/utils/state_management/state_management_utils.dart';

part 'search_history_manager.dart';

abstract interface class SearchHistoryManagerInterface {
  List<String> get currentHistory;

  Future<void> clearHistory();

  Future<void> addSearchQuery(String query);

  List<String> fetchSearchQueries();
}
