part of '../home_screen.dart';

class AddTaskFloatingButton extends StatefulWidget {
  final ValueNotifier<double> drawerOffsetNotifier;

  const AddTaskFloatingButton({
    Key? key,
    required this.drawerOffsetNotifier,
  }) : super(key: key);

  @override
  State<AddTaskFloatingButton> createState() => _AddTaskFloatingButtonState();
}

class _AddTaskFloatingButtonState extends State<AddTaskFloatingButton> {
  Future<void> onPressed() async {
    await context.pushNamed(AppRoute.task.name);
    if (!mounted) return;
    context.read<HomeVanilla>().fetchTasks();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<double>(
      valueListenable: widget.drawerOffsetNotifier,
      builder: (_, offset, __) {
        final bool showing = offset.isAroundOrLessThan(0);
        return Visibility(
          visible: showing,
          child: SmallButton(
            onPressed: onPressed,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                8.boxWidth,
                SvgDecorator.square(
                  dimension: 24.l,
                  color: context.bgColors.$50,
                  child: SvgPicture.asset(VectorAssets.add),
                ),
                8.boxWidth,
                Text(
                  'Add New task',
                  style: context.buttonTextStyle.copyWith(
                    color: context.bgColors.$50,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
