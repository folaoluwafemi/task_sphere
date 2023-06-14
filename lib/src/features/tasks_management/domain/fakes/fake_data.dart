import 'dart:math';

import 'package:task_sphere/src/features/tasks_management/task_management_barrel.dart';
import 'package:task_sphere/src/utils/functions/util_functions.dart';

abstract final class FakeData {
  static final List<Task> tasks = List.generate(
    4,
    (index) => generateTask(DateTime.now()),
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
          createdAt: createdAt,
          content: 'Create user flows for basic usage of finding services',
        ),
      ),
    );
  }

  static Todo generateTodo({
    required DateTime createdAt,
    required String content,
  }) {
    return Todo(
      id: UtilFunctions.generateId(),
      content: content,
      createdAt: createdAt,
      priority: Random().nextBool() ? Priority.medium : Priority.high,
      status: Random().nextBool() ? Status.todo : Status.done,
      updatedAt: createdAt,
    );
  }
}
