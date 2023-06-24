part of '../task_screen.dart';

class _TaskView extends StatefulWidget {
  final List<Todo> todos;

  const _TaskView({
    Key? key,
    required this.todos,
  }) : super(key: key);

  @override
  State<_TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<_TaskView> {
  late final List<Todo> todos = widget.todos;

  @override
  Widget build(BuildContext context) {
    return ReorderableList(
      onReorder: onReorder,
      onReorderDone: onReorderDone,
      child: VanillaBuilder<TaskVanilla, TaskState>(
        buildWhen: (previous, current) {
          return previous?.showAchievement != current.showAchievement;
        },
        builder: (context, state) {
          return CustomScrollView(
            physics: const ClampingScrollPhysics(),
            slivers: [
              SliverStack(
                children: [
                  state.showAchievement
                      ? const SliverToBoxAdapter(child: _TaskAchievement())
                      : SliverSafeArea(
                          top: false,
                          sliver: MultiSliver(
                            children: [
                              const SliverToBoxAdapter(child: _TitleView()),
                              _TodoView(todos: todos),
                              18.sliverBoxHeight,
                              const SliverToBoxAdapter(child: CreatedDate()),
                              150.boxHeight,
                            ],
                          ),
                        ),
                  const SliverPinnedHeader(child: _PinnedHeader()),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  bool onReorder(Key draggedKey, Key newKey) {
    draggedKey = draggedKey as ValueKey<DateTime>;
    newKey = newKey as ValueKey<DateTime>;

    final int draggedIndex = todos.indexWhere((element) {
      return ValueKey(element.updatedAt) == draggedKey;
    });

    final int newIndex = todos.indexWhere((element) {
      return ValueKey(element.updatedAt) == newKey;
    });

    final Todo draggedTodo = todos[draggedIndex];

    setState(() {
      todos.removeAt(draggedIndex);
      todos.insert(newIndex, draggedTodo);
    });

    return true;
  }

  void onReorderDone(Key newKey) {
    final int newIndex = todos.indexWhere((element) {
      return ValueKey(element.updatedAt) == newKey;
    });

    Todo newTodo = todos[newIndex];

    if (newIndex == 0) {
      newTodo = newTodo.copyWith(updatedAt: DateTime.now());
    } else if (newIndex == todos.lastIndex) {
      newTodo = newTodo.copyWith(
        updatedAt: todos[newIndex - 1].updatedAt.subtract(
              const Duration(seconds: 1),
            ),
      );
    } else {
      final DateTime precedingDate = todos[newIndex - 1].updatedAt;
      final DateTime succeedingDate = todos[newIndex + 1].updatedAt;

      newTodo = newTodo.copyWith(
        updatedAt: precedingDate.getTimeBetween(succeedingDate),
      );
    }

    todos.clearDuplicatesWhere(
      (element1, element2) => element1.id == element2.id,
    );

    setState(() {
      todos[newIndex] = newTodo;
      todos.sort();
    });
    context.read<TaskVanilla>().updateTodos(todos);
  }
}

class CreatedDate extends StatelessWidget {
  const CreatedDate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DateTime createdAt = context.read<TaskVanilla>().state.task.createdAt;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(
          color: context.neutralColors.$400,
          thickness: 1.h,
          height: 1.h,
        ),
        8.boxHeight,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          child: Text(
            formatDate(createdAt),
            style: context.secondaryTypography.caption.medium
                .withColor(context.neutralColors.$600),
          ),
        ),
      ],
    );
  }

  String formatDate(DateTime date) {
    final String month = DateFormat.MMM().format(date);
    final String day = date.day.toOrdinal();
    final String year = date.year.toString().substring(2);
    final String time = DateFormat.jm().format(date).removeAll(' ');

    final bool isToday = date.day == DateTime.now().day;

    return 'CREATED${isToday ? ' TODAY' : ''}: $day $month, $year | $time'
        .toUpperCase();
  }
}
