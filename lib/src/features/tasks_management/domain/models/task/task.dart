import 'package:task_sphere/src/features/tasks_management/task_management_barrel.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_sphere/src/utils/utils_barrel.dart';

class Task {
  final String id;
  final String title;
  final String description;
  final List<Todo> todos;
  final DateTime createdAt;

  const Task({
    required this.id,
    required this.title,
    required this.description,
    required this.todos,
    required this.createdAt,
  });

  Task.create({
    required this.title,
    required this.description,
    required this.todos,
    required this.createdAt,
  }) : id = UtilFunctions.generateId();

  DateTime get updatedAt => todos.reduce((value, element) {
        return value.updatedAt.isAfter(element.updatedAt) ? value : element;
      }).updatedAt;

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      todos: List<Todo>.from(map['todos']?.map((data) => Todo.fromMap(data))),
      createdAt: UtilFunctions.parseDateTime(map['createdAt']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'todos': todos.map((todo) => todo.toMap()).toList(),
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
