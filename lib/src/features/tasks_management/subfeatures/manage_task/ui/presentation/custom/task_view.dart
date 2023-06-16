part of '../task_screen.dart';

class _TaskView extends StatefulWidget {
  const _TaskView({Key? key}) : super(key: key);

  @override
  State<_TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<_TaskView> {
  late final List<Todo> todos = FakeData.todos;

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

    setState(() {
      todos[newIndex] = newTodo;
      todos.sort();
    });
    context.read<TaskVanilla>().updateTodos(todos);
  }

  void onTaskTitleChanged(String value) {}

  void onTaskDescriptionChanged(String value) {}

  @override
  Widget build(BuildContext context) {
    return ReorderableList(
      onReorder: onReorder,
      onReorderDone: onReorderDone,
      child: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          SliverStack(
            children: [
              MultiSliver(
                children: [
                  SliverToBoxAdapter(
                    child: _TitleView(
                      onTitleChanged: onTaskTitleChanged,
                      onDescriptionChanged: onTaskDescriptionChanged,
                    ),
                  ),
                  _TodoView(todos: todos),
                ],
              ),
              const SliverPinnedHeader(
                child: _PinnedHeader(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
