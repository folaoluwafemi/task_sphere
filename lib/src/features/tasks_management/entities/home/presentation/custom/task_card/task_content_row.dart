part of 'task_card.dart';

class _TaskContentRow extends StatelessWidget {
  final Task task;

  const _TaskContentRow({
    Key? key,
    required this.task,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16.w, top: 22.h),
      child: Row(
        children: [
          SizedBox(
            width: 236.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.title,
                  style: context.primaryTypography.title.small,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                9.boxHeight,
                Text(
                  task.description,
                  style: context.secondaryTypography.caption.regular
                      .withColor(context.neutralColors.$700)
                      .withHeight(1.173),
                ),
              ],
            ),
          ),
          const Spacer(),
          TaskProgressWidget(task: task),
          25.boxWidth,
        ],
      ),
    );
  }
}
