import 'package:task_sphere/src/features/tasks_management/task_management_barrel.dart';
import 'package:task_sphere/src/utils/utils_barrel.dart';

class Task implements Comparable<Task> {
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

  Task.empty()
      : this.create(
          title: '',
          description: '',
          todos: [],
          createdAt: DateTime.now(),
        );

  bool get isEmpty => title.isEmpty && description.isEmpty && todos.isEmpty;

  bool get isCompleted => todos.every((todo) => todo.status == Status.done);

  bool get isTodo => !isCompleted;

  bool get isCanceled => todos.every((todo) => todo.status == Status.canceled);

  double get progressPercentage {
    final Iterable<Todo> doneTodos = todos.where((todo) {
      return todo.status == Status.done;
    });
    return (doneTodos.length / todos.length) * 100;
  }

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

  Task copyWith({
    String? id,
    String? title,
    String? description,
    List<Todo>? todos,
    DateTime? createdAt,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      todos: todos ?? this.todos,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  int compareTo(Task other) => other.updatedAt.compareTo(updatedAt);
}
