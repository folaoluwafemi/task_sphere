part of '../todo.dart';

enum TodoDescriptor {
  content,
  priority,
  status,
  all;

  dynamic dataFromTodo(Todo todo) {
    return switch (this) {
      content => todo.content,
      priority => todo.priority,
      status => todo.status,
      all => todo.id,
    };
  }

  String contentFrom(String value) {
    assert(
      this == content,
      'cannot generate priority from wrong descriptor',
    );
    return value;
  }

  Priority priorityFrom(String value) {
    assert(
      this == priority,
      'cannot generate priority from wrong descriptor',
    );

    return Priority.fromName(value);
  }

  Status statusFrom(String value) {
    assert(
      this == status,
      'cannot generate priority from wrong descriptor',
    );

    return Status.fromName(value);
  }

  String idFrom(String value) {
    assert(
      this == all,
      'cannot generate priority from wrong descriptor',
    );

    return value.toString();
  }

  dynamic dataFromValue(String value) {
    return switch (this) {
      content => contentFrom(value),
      priority => priorityFrom(value),
      status => statusFrom(value),
      all => idFrom(value),
    };
  }

  factory TodoDescriptor.fromName(String name) {
    name = name.cleanLower;
    return switch (name) {
      'content' => content,
      'priority' => priority,
      'status' => status,
      'all' => all,
      _ => throw UnsupportedError('$name is not supported'),
    };
  }
}
