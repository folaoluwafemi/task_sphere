import 'package:task_sphere/src/features/tasks_management/task_management_barrel.dart';

enum SearchFilter {
  all,
  tasks,
  todos,
  ;

  List<SearchResult> applyTo(List<SearchResult> results) => switch (this) {
        all => List.from(results),
        tasks => results.where((element) => element.value == null).toList(),
        todos => results.where((element) => element.value != null).toList(),
      }
        ..sort();
}
