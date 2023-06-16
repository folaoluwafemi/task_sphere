import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:task_sphere/src/entities/app/app_barrel.dart';
import 'package:task_sphere/src/features/tasks_management/task_management_barrel.dart';
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
    return GestureDetector(
      onTap: () => context.goNamed(AppRoute.task.name, extra: task),
      child: TaskCardContainer(
        child: Column(
          children: [
            _TaskContentRow(task: task),
            _TodoContent(task: task),
          ],
        ),
      ),
    );
  }
}
