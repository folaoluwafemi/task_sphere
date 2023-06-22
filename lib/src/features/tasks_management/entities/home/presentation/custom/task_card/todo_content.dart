part of 'task_card.dart';

class _TodoContent extends StatelessWidget {
  final Task task;

  const _TodoContent({
    Key? key,
    required this.task,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: task.todos.length <= 2
          ? EdgeInsets.only(bottom: 12.h)
          : EdgeInsets.zero,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Stack(
              children: [
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 11.h, bottom: 8.h),
                    child: Container(
                      width: 339.w,
                      decoration: BoxDecoration(
                        borderRadius: Ui.circularBorder(7.l),
                        gradient: LinearGradient(
                          transform: GradientRotation(90.toRadians),
                          stops: const [0.4, 1],
                          colors: [
                            context.neutralColors.$100,
                            context.neutralColors.$100.withOpacity(0),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 10.w,
                    right: 10.w,
                    top: 16.h,
                  ),
                  child: Container(
                    width: double.infinity,
                    constraints: BoxConstraints(
                      maxHeight: 101.h,
                    ),
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: task.todos.length,
                      padding: EdgeInsets.zero,
                      separatorBuilder: (context, index) => 4.boxHeight,
                      itemBuilder: (context, index) => TodoItemWidget(
                        todo: task.todos[index],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              constraints: BoxConstraints(
                maxHeight: 111.h,
              ),
              decoration: BoxDecoration(
                borderRadius: Ui.circularBorder(7.l),
                gradient: LinearGradient(
                  transform: GradientRotation(90.toRadians),
                  stops: const [-0.9, 1],
                  colors: [
                    context.bgColors.$50.withOpacity(0),
                    context.bgColors.$50.withOpacity(1),
                  ],
                ),
              ),
              child: Visibility.maintain(
                visible: false,
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: task.todos.length,
                  padding: EdgeInsets.zero,
                  separatorBuilder: (context, index) => 4.boxHeight,
                  itemBuilder: (context, index) => TodoItemWidget(
                    todo: task.todos[index],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
