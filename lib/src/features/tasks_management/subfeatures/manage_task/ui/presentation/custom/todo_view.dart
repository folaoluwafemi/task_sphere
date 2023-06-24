part of '../task_screen.dart';

class _TodoView extends StatefulWidget {
  final List<Todo> todos;

  const _TodoView({
    Key? key,
    required this.todos,
  }) : super(key: key);

  @override
  State<_TodoView> createState() => _TodoViewState();
}

typedef TodoAndKey = (Todo todo, Key key);

class _TodoViewState extends State<_TodoView> {
  late final List<Todo> todos = widget.todos;

  void onTodoChanged({
    required Todo todo_,
    required int index,
    required bool deleted,
  }) {
    if (todo_.status == Status.canceled || todo_.status == Status.done) {
      final Todo leastRecentTodo = todos.reduce((value, element) {
        return value.updatedAt.isBefore(element.updatedAt) ? value : element;
      });

      todo_ = todo_.copyWith(
        updatedAt: leastRecentTodo.updatedAt.copySubtract(seconds: 2),
      );
    }

    todos.removeAt(index);
    if (deleted) {
      context.read<TaskVanilla>().deleteTodo(todo_);
      return setState(() => todos.sort());
    }

    todos.clearDuplicatesWhere(
      (element1, element2) => element1.id == element2.id,
    );

    setState(
      () => todos
        ..insert(index, todo_)
        ..sort(),
    );

    context.read<TaskVanilla>().updateTodo(todo_);
  }

  void onNewTodoAdded(Todo todo) {
    setState(() {
      todos
        ..add(todo)
        ..sort();
    });

    todos.clearDuplicatesWhere(
      (element1, element2) => element1.id == element2.id,
    );

    context.read<TaskVanilla>().addTodo(todo);
  }

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 18.w),
      sliver: MultiSliver(
        children: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                18.boxHeight,
                Text(
                  'CREATE TODOS',
                  style: context.primaryTypography.paragraph.small.asMedium
                      .withColor(context.palette.primary),
                ),
                32.boxHeight,
                TodoWidget.new_(
                  onChanged: (value) => onNewTodoAdded(value.$1),
                ),
                24.boxHeight,
              ],
            ),
          ),
          SliverList.separated(
            separatorBuilder: (_, __) => 24.boxHeight,
            itemCount: todos.length,
            itemBuilder: (context, index) => ReorderableItem(
              key: ValueKey<DateTime>(todos[index].updatedAt),
              childBuilder: (context, state) {
                final Todo todo = todos[index];
                return switch (state) {
                  ReorderableItemState.normal => TodoWidget(
                      todo: todo,
                      onChanged: (value) => onTodoChanged(
                        todo_: value.$1,
                        index: index,
                        deleted: value.$2,
                      ),
                    ),
                  ReorderableItemState.placeholder => Opacity(
                      opacity: 0,
                      child: TodoWidget(
                        todo: todo,
                        onChanged: (value) {},
                      ),
                    ),
                  ReorderableItemState.dragProxy => TodoWidget(
                      todo: todo,
                      onChanged: (value) => onTodoChanged(
                        todo_: value.$1,
                        index: index,
                        deleted: value.$2,
                      ),
                    ),
                  ReorderableItemState.dragProxyFinished => TodoWidget(
                      todo: todo,
                      onChanged: (value) => onTodoChanged(
                        todo_: value.$1,
                        index: index,
                        deleted: value.$2,
                      ),
                    ),
                };
              },
            ),
          ),
        ],
      ),
    );
  }
}
