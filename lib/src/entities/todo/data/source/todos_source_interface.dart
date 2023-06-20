import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_sphere/src/entities/entities_barrel.dart';
import 'package:task_sphere/src/entities/todo/todo_barrel.dart';
import 'package:task_sphere/src/utils/utils_barrel.dart';

part 'todos_source.dart';

abstract interface class TodoSourceInterface {
  Future<void> addTodo(Todo todo);

  Future<List<Todo>> readTodos();

  Future<void> updateTodos(List<Todo> todos);

  Future<void> deleteTodo(Todo todo);

  Future<void> deleteAllTodos();
}
