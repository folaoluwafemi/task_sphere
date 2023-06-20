part of '../home_screen.dart';

class AddTaskFloatingButton extends StatelessWidget {
  final ValueNotifier<double> drawerOffsetNotifier;

  const AddTaskFloatingButton({
    Key? key,
    required this.drawerOffsetNotifier,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<double>(
      valueListenable: drawerOffsetNotifier,
      builder: (_, offset, __) {
        final bool showing = offset.isAroundOrLessThan(0);
        return Visibility(
          visible: showing,
          child: SmallButton(
            onPressed: () => context.goNamed(AppRoute.task.name),
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
