import 'package:flutter/material.dart' hide ReorderableList;
import 'package:flutter_reorderable_list/flutter_reorderable_list.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:task_sphere/src/entities/app/ui/components/components_barrel.dart';
import 'package:task_sphere/src/entities/task/task_barrel.dart';
import 'package:task_sphere/src/entities/todo/todo_barrel.dart';
import 'package:task_sphere/src/features/tasks_management/subfeatures/manage_task/ui/state_mgmt/task_vanilla.dart';
import 'package:task_sphere/src/utils/utils_barrel.dart';
import 'package:vanilla_state/vanilla_state.dart';

part 'custom/descriptor_modals.dart';

part 'custom/descriptor_picker_dialog.dart';

part 'custom/more.dart';

part 'custom/pinned_header.dart';

part 'custom/right_item_widget.dart';

part 'custom/task_achievement_view.dart';

part 'custom/task_view.dart';

part 'custom/title_fields.dart';

part 'custom/title_view.dart';

part 'custom/todo_view.dart';

part 'custom/todo_widget.dart';

class TaskScreen extends StatelessWidget {
  final Task? task;

  const TaskScreen({
    Key? key,
    this.task,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InheritedVanilla<TaskVanilla>(
      createNotifier: () => TaskVanilla(task: task)..initialize(),
      child: VanillaListener<TaskVanilla, TaskState>(
        listenWhen: (previous, current) => previous?.error != current.error,
        listener: (previous, current) {
          if (current.error != null) {
            AlertType.error.show(
              context,
              text: current.error?.message ?? ErrorMessages.unknown,
            );
          }
        },
        child: VanillaBuilder<TaskVanilla, TaskState>(
          builder: (context, state) {
            return Scaffold(
              appBar: state.showAchievement
                  ? null
                  : AppBar(
                      toolbarHeight: 0,
                      elevation: 0,
                      backgroundColor: context.bgColors.$50,
                    ),
              backgroundColor: context.bgColors.$100,
              body: _TaskView(todos: state.task.todos),
            );
          },
        ),
      ),
    );
  }
}
