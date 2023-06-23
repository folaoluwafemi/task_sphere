import 'package:task_sphere/src/entities/todo/todo_barrel.dart';
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

  @override
  String toString() {
    return '''
    Task{
      id: $id,
      title: $title,
      description: $description,
      todos: $todos,
      createdAt: $createdAt
    }''';
  }

  int get productivityPoint => todos.fold<int>(0, (previousValue, todo) {
        final int todoPoint = todo.priority.value * todo.status.multiplier;
        return previousValue + todoPoint;
      });

  bool get isEmpty => title.isEmpty && description.isEmpty && todos.isEmpty;

  bool get isCompleted =>
      todos.isEmpty ? false : todos.every((todo) => todo.status == Status.done);

  bool get isTodo => todos.isEmpty ? false : !isCompleted;

  bool get isCanceled => todos.isEmpty
      ? false
      : todos.every((todo) => todo.status == Status.canceled);

  double get progressPercentage {
    if (todos.isEmpty) return 0;

    final Iterable<Todo> doneTodos = todos.where((todo) {
      return todo.status == Status.done;
    });
    return (doneTodos.length / todos.length) * 100;
  }

  DateTime get updatedAt {
    if (todos.isEmpty) return createdAt;
    return todos.reduce((value, element) {
      return value.updatedAt.isAfter(element.updatedAt) ? value : element;
    }).updatedAt;
  }

  Task copyWithTodosCompleted() {
    final List<Todo> todos_ = [];
    for (final Todo todo in todos) {
      todos_.add(todo.copyWith(status: Status.done));
    }
    return copyWith(todos: todos_);
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      todos: List<Todo>.from(
        map['todos']?.map<Todo>((data) => Todo.fromMap((data as Map).cast())) ??
            [],
      ),
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
