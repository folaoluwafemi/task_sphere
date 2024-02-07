import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_sphere/src/entities/entities_barrel.dart';
import 'package:task_sphere/src/entities/task/task_barrel.dart';
import 'package:task_sphere/src/utils/utils_barrel.dart';
import 'package:vanilla_state/vanilla_state.dart';

part 'tasks_reader.dart';

abstract interface class TasksReaderInterface {
  List<Task> get tasks;

  Stream<List<Task>> get stream;

  Future<List<Task>> fetch({
    bool aFresh = false,
    bool more = true,
  });

  void clearCurrentTasks();
}
