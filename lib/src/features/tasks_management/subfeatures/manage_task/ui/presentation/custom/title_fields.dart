part of '../task_screen.dart';

class _TitleFields extends StatefulWidget {
  const _TitleFields({
    Key? key,
  }) : super(key: key);

  @override
  State<_TitleFields> createState() => _TitleFieldsState();
}

class _TitleFieldsState extends State<_TitleFields> {
  final FocusNode titleFocusNode = FocusNode();
  final FocusNode descriptionFocusNode = FocusNode();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final Task task = context.read<TaskVanilla>().state.task;
    titleController.text = task.title;
    descriptionController.text = task.description;
  }

  @override
  void initState() {
    super.initState();
    titleFocusNode.addListener(titleNodeListener);
    descriptionFocusNode.addListener(descriptionNodeListener);
  }

  bool titleWasFocused = false;
  bool descriptionWasFocused = false;

  void titleNodeListener() {
    if (!titleFocusNode.hasFocus && titleWasFocused) {
      titleWasFocused = false;
      onTitleSaved();
    }

    if (titleFocusNode.hasFocus) titleWasFocused = true;
  }

  void descriptionNodeListener() {
    if (!descriptionFocusNode.hasFocus && descriptionWasFocused) {
      descriptionWasFocused = false;
      onDescriptionSaved();
    }

    if (descriptionFocusNode.hasFocus) {
      descriptionWasFocused = true;
    }
  }

  void onTitleSaved() {
    title = title.trim();
    if (title.isEmpty) return;
    context.read<TaskVanilla>().updateTitle(title);
  }

  void onDescriptionSaved() {
    description = description.trim();
    if (description.isEmpty) return;
    context.read<TaskVanilla>().updateDescription(description);
  }

  @override
  void dispose() {
    titleFocusNode.dispose();
    descriptionFocusNode.dispose();
    super.dispose();
  }

  String title = '';

  void onTitleChanged(String value) {
    title = value;
  }

  String description = '';

  void onDescriptionChanged(String value) {
    description = value;
  }

  late final bool autofocus =
      context.read<TaskVanilla>().state.task.title.isEmpty;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          autofocus: autofocus,
          controller: titleController,
          onChanged: onTitleChanged,
          onSubmitted: onTitleChanged,
          focusNode: titleFocusNode,
          style: context.primaryTypography.title.large,
          decoration: InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.zero,
            hintText: 'New Task Name',
            hintStyle: context.primaryTypography.title.large.copyWith(
              color: context.neutralColors.$500,
            ),
            border: InputBorder.none,
          ),
        ),
        24.boxHeight,
        TextField(
          controller: descriptionController,
          focusNode: descriptionFocusNode,
          onChanged: onDescriptionChanged,
          onSubmitted: onDescriptionChanged,
          style: context.secondaryTypography.paragraph.large.copyWith(
            fontWeight: FontWeight.w400,
            color: context.neutralColors.$600,
          ),
          maxLines: null,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.zero,
            isDense: true,
            hintText: 'Add description...',
            hintStyle: context.secondaryTypography.paragraph.large.copyWith(
              fontWeight: FontWeight.w400,
              color: context.neutralColors.$600,
            ),
            border: InputBorder.none,
          ),
        ),
      ],
    );
  }
}
