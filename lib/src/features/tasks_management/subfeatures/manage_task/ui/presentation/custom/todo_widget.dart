part of '../task_screen.dart';

class TodoWidget extends StatefulWidget {
  final bool isNew;
  final Todo? _todo;
  final ValueChanged<(Todo todo, bool isDeleted)> onChanged;

  const TodoWidget({
    Key? key,
    required Todo todo,
    required this.onChanged,
  })  : _todo = todo,
        isNew = false,
        super(key: key);

  const TodoWidget.new_({
    Key? key,
    required this.onChanged,
  })  : _todo = null,
        isNew = true,
        super(key: key);

  @override
  State<TodoWidget> createState() => _TodoWidgetState();
}

class _TodoWidgetState extends State<TodoWidget> {
  late Todo? todo = widget._todo;
  late final bool isNew = widget.isNew;
  late final TextEditingController contentController = TextEditingController(
    text: todo?.content ?? '',
  );

  final FocusNode focusNode = FocusNode();

  void deleteTodo() {
    if (isNew) return;
    widget.onChanged((todo!, true));
  }

  void onSubmit(String text) {
    if (text.isEmpty) return deleteTodo();

    if (isNew) {
      contentController.clear();
      return widget.onChanged((Todo.create(content: content), false));
    }

    widget.onChanged((todo!.copyWith(content: content), false));
    focusNode.unfocus();
  }

  late String content = todo?.content ?? '';

  void onChanged(String value) {
    content = value;
  }

  late final bool autofocus = isNew;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ReorderableListener(
          canStart: () => !isNew,
          child: SvgDecorator.square(
            color:
                isNew ? context.neutralColors.$400 : context.neutralColors.$500,
            dimension: 24.l,
            child: SvgPicture.asset(VectorAssets.reorder),
          ),
        ),
        16.boxWidth,
        Flexible(
          child: TextField(
            autofocus: autofocus,
            onChanged: onChanged,
            focusNode: focusNode,
            controller: contentController,
            textInputAction: TextInputAction.done,
            onSubmitted: onSubmit,
            maxLines: null,
            style: context.secondaryTypography.paragraph.medium.asRegular,
            decoration: InputDecoration(
              hintText: 'Enter item',
              hintStyle: context.secondaryTypography.paragraph.medium.asRegular
                  .copyWith(color: context.neutralColors.$600),
              isDense: true,
              border: InputBorder.none,
            ),
          ),
        ),
        ListenableBuilder(
          listenable: focusNode,
          builder: (_, __) => RightItemWidget(
            onDescriptorsPressed: onDescriptorPressed,
            onDonePressed: onDone,
            todo: todo,
            isCurrentlyEditing: focusNode.hasFocus,
          ),
        ),
      ],
    );
  }

  void onDescriptorChanged(_DescriptorRecord value) {
    final Todo todo_ = todo!;
    todo = todo!.copyWith(
      status: value.$1,
      priority: value.$2,
      updatedAt: DateTime.now(),
    );
    if (todo_ != todo) widget.onChanged((todo!, false));
  }

  void onDescriptorPressed() {
    showDialog(
      context: context,
      builder: (context) => _DescriptorPickerDialog(
        onChanged: onDescriptorChanged,
        initialValue: (todo!.status, todo!.priority),
      ),
    );
  }

  void onDone() {
    onSubmit(contentController.text);
  }

  @override
  void dispose() {
    contentController.dispose();
    focusNode.dispose();
    super.dispose();
  }
}
