part of 'task_card.dart';

class _TodoContent extends StatelessWidget {
  final Task task;

  const _TodoContent({
    Key? key,
    required this.task,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 121.h,
      child: Stack(
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
                    top: 26.h,
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    height: 100.h,
                    child: ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: task.todos.length,
                      padding: EdgeInsets.zero,
                      separatorBuilder: (context, index) => 4.boxHeight,
                      itemBuilder: (context, index) => _TodoItemWidget(
                        todo: task.todos[index],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 121.l,
            width: double.infinity,
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
          ),
        ],
      ),
    );
  }
}
