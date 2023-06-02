part of '../todo.dart';

enum Status {
  todo,
  done,
  canceled,
  ;

  factory Status.fromName(String name) {
    name = name.cleanLower;
    return switch (name) {
      'todo' => todo,
      'done' => done,
      'canceled' => canceled,
      _ => throw UnsupportedError('$name is not supported'),
    };
  }
}
