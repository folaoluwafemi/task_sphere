part of '../task_screen.dart';

class RightItemWidget extends StatelessWidget {
  final Todo? todo;
  final bool isCurrentlyEditing;
  final VoidCallback onDonePressed;
  final VoidCallback onDescriptorsPressed;

  const RightItemWidget({
    Key? key,
    this.todo,
    required this.isCurrentlyEditing,
    required this.onDonePressed,
    required this.onDescriptorsPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isCurrentlyEditing) return _DoneButton(onPressed: onDonePressed);

    if (todo == null) {
      return SvgDecorator.square(
        dimension: 24.l,
        child: SvgPicture.asset(VectorAssets.menuDots),
      );
    }
    return InkWell(
      onTap: onDescriptorsPressed,
      child: _TodoDescriptorPairWidget(
        todo: todo!,
        onPressed: onDescriptorsPressed,
      ),
    );
  }
}

class _DoneButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _DoneButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: Ui.circularBorder(4.m),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 6.w),
        child: SvgDecorator.square(
          dimension: 20.l,
          color: context.alertColors.success,
          child: SvgPicture.asset(
            VectorAssets.add,
          ),
        ),
      ),
    );
  }
}

class _TodoDescriptorPairWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final Todo todo;

  const _TodoDescriptorPairWidget({
    Key? key,
    required this.todo,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: Ui.circularBorder(6.l),
          border: Border.all(color: context.neutralColors.$400, width: 0.5.l),
          color: context.neutralColors.$100,
        ),
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            todo.priority.widgetWithDimension(20.l),
            12.boxWidth,
            SvgDecorator.square(
              dimension: 20.l,
              color: context.neutralColors.$800,
              child: SvgPicture.asset(
                todo.status.vectorAsset,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
