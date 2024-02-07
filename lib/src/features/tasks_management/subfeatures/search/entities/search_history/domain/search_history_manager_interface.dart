import 'package:task_sphere/src/features/tasks_management/subfeatures/search/entities/search_history/data/search_history_source_interface.dart';
import 'package:vanilla_state/vanilla_state.dart';

part 'search_history_manager.dart';

abstract interface class SearchHistoryManagerInterface {
  List<String> get currentHistory;

  Future<void> clearHistory();

  Future<void> addSearchQuery(String query);

  List<String> fetchSearchQueries();
}
