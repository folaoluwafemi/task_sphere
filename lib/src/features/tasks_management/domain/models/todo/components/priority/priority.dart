part of '../todo.dart';

enum Priority {
  none,
  low,
  medium,
  high;

  factory Priority.fromName(String name) {
    name = name.cleanLower;
    return switch (name) {
      'none' => none,
      'low' => low,
      'medium' => medium,
      'high' => high,
      _ => throw UnsupportedError('$name is not supported'),
    };
  }
}
