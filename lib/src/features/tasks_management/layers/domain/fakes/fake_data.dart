import 'dart:math';

import 'package:task_sphere/src/entities/task/task_barrel.dart';
import 'package:task_sphere/src/entities/todo/todo_barrel.dart';
import 'package:task_sphere/src/utils/functions/extensions/extensions.dart';
import 'package:task_sphere/src/utils/functions/util_functions.dart';

abstract final class FakeData {
  static final List<Task> tasks = List.generate(
    4,
    (index) => generateTask(DateTime.now()),
  );

  static final List<Todo> todos = List.generate(
    4,
    (index) => generateTodo(
      index: index,
      createdAt: DateTime.now(),
      content: 'Balablu balablu balablu balablu balablu',
    ),
  );

  static Task generateTask(DateTime createdAt) {
    return Task(
      id: UtilFunctions.generateId(),
      title: 'Renda App Design',
      description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit,'
          ' sed do eiusmod tempor incididunt ut labore et dolore.',
      createdAt: createdAt,
      todos: List.generate(
        3,
        (index) => generateTodo(
          index: index,
          createdAt: createdAt,
          content: 'Create user flows for basic usage of finding services',
        ),
      ),
    );
  }

  static Todo generateTodo({
    required int index,
    required DateTime createdAt,
    required String content,
  }) {
    final DateTime updatedAt =
        createdAt.copyWith(minute: 59, hour: -1).copySubtract(minutes: index);
    return Todo(
      id: updatedAt.millisecondsSinceEpoch.toString(),
      content: content,
      createdAt: createdAt,
      priority: Random().nextBool() ? Priority.medium : Priority.high,
      status: Random().nextBool() ? Status.todo : Status.done,
      updatedAt: updatedAt,
    );
  }
}
