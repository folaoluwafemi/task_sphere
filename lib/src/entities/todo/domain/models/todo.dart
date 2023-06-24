import 'package:task_sphere/src/entities/todo/todo_barrel.dart';
import 'package:task_sphere/src/utils/utils_barrel.dart';

part 'components/todo_descriptors.dart';

class Todo implements Comparable<Todo> {
  final String id;
  final String content;
  final Priority priority;
  final Status status;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Todo({
    required this.id,
    required this.content,
    required this.priority,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  bool get isDone => status == Status.done;

  Todo.create({
    required this.content,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : priority = Priority.low,
        status = Status.todo,
        createdAt = updatedAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now(),
        id = UtilFunctions.generateId();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Todo &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          content == other.content &&
          priority == other.priority &&
          status == other.status &&
          createdAt == other.createdAt &&
          updatedAt == other.updatedAt);

  @override
  int get hashCode =>
      id.hashCode ^
      content.hashCode ^
      priority.hashCode ^
      status.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode;

  Todo copyWith({
    String? id,
    String? content,
    Priority? priority,
    Status? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Todo(
      id: id ?? this.id,
      content: content ?? this.content,
      priority: priority ?? this.priority,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? DateTime.now(),
    );
  }

  @override
  String toString() {
    return '''
    Todo{
      id: $id,
      content: $content
      priority: $priority
      status: $status
      createdAt: $createdAt
      updatedAt: $updatedAt
    }''';
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'content': content,
      'priority': priority.index,
      'status': status.index,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'] as String,
      content: map['content'] as String,
      priority: Priority.values[map['priority'] as int],
      status: Status.values[map['status'] as int],
      createdAt: UtilFunctions.parseDateTime(map['createdAt']),
      updatedAt: UtilFunctions.parseDateTime(map['updatedAt']),
    );
  }

  @override
  int compareTo(Todo other) {
    return other.updatedAt.compareTo(updatedAt);
  }
}
