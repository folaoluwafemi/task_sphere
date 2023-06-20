part of '../task_screen.dart';

class _MoreButton extends StatefulWidget {
  const _MoreButton({Key? key}) : super(key: key);

  @override
  State<_MoreButton> createState() => _MoreButtonState();
}

class _MoreButtonState extends State<_MoreButton> {
  @override
  Widget build(BuildContext context) {
    return VanillaBuilder<TaskVanilla, TaskState>(
      buildWhen: (previous, current) =>
          previous?.isNew != current.isNew ||
          previous?.task.isEmpty != current.task.isEmpty,
      builder: (context, state) {
        if (state.isNew || state.task.isEmpty) return const SizedBox.shrink();

        return Padding(
          padding: EdgeInsets.only(right: 18.w, top: 14.h),
          child: InkWell(
            borderRadius: Ui.circularBorder(50.l),
            onTap: onMorePressed,
            child: SvgDecorator.square(
              dimension: 20.l,
              color: context.neutralColors.$700,
              child: SvgPicture.asset(VectorAssets.moreVertical),
            ),
          ),
        );
      },
    );
  }

  OverlayEntry? moreOverlayEntry;

  void onMorePressed() {
    moreOverlayEntry = OverlayEntry(
      builder: (_) => _MoreOverlay(
        taskVanilla: context.read<TaskVanilla>(),
        closeCallback: closeOverlayEntry,
      ),
    );

    Overlay.of(context).insert(moreOverlayEntry!);
  }

  void closeOverlayEntry(Function(BuildContext context) function) {
    moreOverlayEntry?.remove();
    function(context);
  }
}

enum _MoreOption {
  markAsCompleted('Mark task as completed', VectorAssets.done),
  trash('Delete task', VectorAssets.deleteOutlined),
  ;

  final String title, vectorAsset;

  const _MoreOption(this.title, this.vectorAsset);
}

class _MoreOverlay extends StatelessWidget {
  final TaskVanilla taskVanilla;
  final ValueChanged<Function(BuildContext context)> closeCallback;

  const _MoreOverlay({
    Key? key,
    required this.taskVanilla,
    required this.closeCallback,
  }) : super(key: key);

  void onOptionPressed(_MoreOption option) {
    switch (option) {
      case _MoreOption.markAsCompleted:
        closeCallback(
          (context) => taskVanilla.markAllTodoCompleted().then(
            (value) {
              if (taskVanilla.state.showAchievement) return;
              context.pop();
            },
          ),
        );
        break;
      case _MoreOption.trash:
        closeCallback(
          (context) => taskVanilla.deleteTask().then((value) => context.pop()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          closeCallback(
            (context) {},
          );
        },
        child: Material(
          color: Colors.transparent,
          child: Padding(
            padding: EdgeInsets.only(right: 19.w, top: 25.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: EdgeInsets.only(top: 8.h, bottom: 16.h),
                  decoration: BoxDecoration(
                    color: context.bgColors.$50,
                    border: Border.all(
                      color: context.neutralColors.$500,
                      width: 1.l,
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _MoreOptionWidget(
                        onPressed: onOptionPressed,
                        option: _MoreOption.trash,
                      ),
                      ValueListenableBuilder<TaskState>(
                        valueListenable: taskVanilla,
                        builder: (context, state, __) {
                          if (state.task.todos.isEmpty) {
                            return const SizedBox.shrink();
                          }
                          return _MoreOptionWidget(
                            onPressed: onOptionPressed,
                            option: _MoreOption.markAsCompleted,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MoreOptionWidget extends StatelessWidget {
  final ValueChanged<_MoreOption> onPressed;
  final _MoreOption option;

  const _MoreOptionWidget({
    Key? key,
    required this.onPressed,
    required this.option,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.h),
      child: GestureDetector(
        onTap: () => onPressed(option),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              20.boxWidth,
              SvgDecorator(
                color: context.neutralColors.$800,
                child: SvgPicture.asset(
                  option.vectorAsset,
                  width: 24.w,
                  height: 24.h,
                ),
              ),
              8.boxWidth,
              Text(
                option.title,
                style: context.secondaryTypography.paragraph.medium.asRegular
                    .withColor(context.neutralColors.$800),
              ),
              24.boxWidth,
            ],
          ),
        ),
      ),
    );
  }
}
