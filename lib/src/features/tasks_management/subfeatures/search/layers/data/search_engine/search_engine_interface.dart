import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_sphere/src/entities/entities_barrel.dart';
import 'package:task_sphere/src/entities/task/task_barrel.dart';
import 'package:task_sphere/src/entities/todo/todo_barrel.dart';
import 'package:task_sphere/src/features/tasks_management/task_management_barrel.dart';
import 'package:task_sphere/src/utils/utils_barrel.dart';

part 'search_engine.dart';

part 'tasks_searcher.dart';

abstract interface class SearchEngineInterface {
  Future<List<SearchResult>> searchFor(
    String query, {
    SearchDateFilter? filter,
  });

  List<SearchResult> searchSync(
    String query, {
    SearchDateFilter? filter,
  });
}
