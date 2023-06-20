part of '../home_screen.dart';

class MenuButton extends StatelessWidget {
  final ValueNotifier<double> drawerOffsetNotifier;
  final VoidCallback toggleDrawer;

  const MenuButton({
    Key? key,
    required this.drawerOffsetNotifier,
    required this.toggleDrawer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: toggleDrawer,
      borderRadius: Ui.circularBorder(6.m),
      child: ValueListenableBuilder<double>(
        valueListenable: drawerOffsetNotifier,
        builder: (_, offset, __) {
          final bool showing = !offset.isAroundOrLessThan(0);
          return Container(
            width: 40.l,
            height: 40.l,
            decoration: BoxDecoration(
              borderRadius: Ui.circularBorder(6.l),
              color: context.neutralColors.$200,
            ),
            child: Center(
              child: SvgDecorator.square(
                dimension: showing ? 20.l : 12.l,
                color: context.neutralColors.$800,
                child: SvgPicture.asset(
                  showing ? VectorAssets.closeX : VectorAssets.fourDots,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
