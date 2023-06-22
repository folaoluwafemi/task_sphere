part of 'task_card.dart';

class TodoItemWidget extends StatelessWidget {
  final Todo todo;

  const TodoItemWidget({
    Key? key,
    required this.todo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: context.neutralColors.$500,
          width: 1.l,
        ),
        borderRadius: Ui.circularBorder(7.l),
      ),
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
      child: Row(
        children: [
          Expanded(
            child: Text(
              todo.content,
              overflow: TextOverflow.ellipsis,
              style: context.primaryTypography.paragraph.small.asRegular,
            ),
          ),
          23.boxWidth,
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              todo.priority.widgetSmall,
              8.boxWidth,
              todo.status.widget,
            ],
          ),
        ],
      ),
    );
  }
}
