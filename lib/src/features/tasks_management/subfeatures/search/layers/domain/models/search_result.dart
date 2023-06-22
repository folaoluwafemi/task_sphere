import 'package:task_sphere/src/entities/task/task_barrel.dart';
import 'package:task_sphere/src/entities/todo/todo_barrel.dart';

class SearchResult implements Comparable<SearchResult> {
  final Task task;
  final Todo? value;

  const SearchResult({
    required this.task,
    this.value,
  });

  bool get isTask => value == null;

  DateTime get updatedAt => value?.updatedAt ?? task.updatedAt;

  DateTime get createdAt => value?.createdAt ?? task.createdAt;

  @override
  int compareTo(SearchResult other) => other.updatedAt.compareTo(updatedAt);
}
