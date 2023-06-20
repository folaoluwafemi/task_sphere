import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_sphere/src/entities/app/app_barrel.dart';
import 'package:task_sphere/src/entities/task/task_barrel.dart';
import 'package:task_sphere/src/entities/todo/todo_barrel.dart';
import 'package:task_sphere/src/utils/utils_barrel.dart';

part 'progress_painter.dart';

part 'task_content_row.dart';

part 'task_progress_widget.dart';

part 'todo_content.dart';

part 'todo_item_widget.dart';

class TaskCard extends StatelessWidget {
  final Task task;

  const TaskCard({
    Key? key,
    required this.task,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TaskCardContainer(
      child: Column(
        children: [
          _TaskContentRow(task: task),
          if (task.todos.isEmpty) 22.boxHeight,
          if (task.todos.isNotEmpty) _TodoContent(task: task),
        ],
      ),
    );
  }
}
