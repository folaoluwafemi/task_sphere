part of '../todo.dart';

enum TodoDescriptor {
  content,
  priority,
  status,
  deadline;

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

  DateTime deadlineFrom(String value) {
    assert(
      this == deadline,
      'cannot generate priority from wrong descriptor',
    );

    return UtilFunctions.parseDateTime(value);
  }

  dynamic dataFromValue(String value) {
    return switch (this) {
      content => contentFrom(value),
      priority => priorityFrom(value),
      status => statusFrom(value),
      deadline => deadlineFrom(value),
    };
  }

  factory TodoDescriptor.fromName(String name) {
    name = name.cleanLower;
    return switch (name) {
      'content' => content,
      'priority' => priority,
      'status' => status,
      'deadline' => deadline,
      _ => throw UnsupportedError('$name is not supported'),
    };
  }
}
