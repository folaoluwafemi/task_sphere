part of '../home_screen.dart';

class _HomeView extends StatelessWidget {
  final VoidCallback showDrawer;

  const _HomeView({
    Key? key,
    required this.showDrawer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
         minWidth: context.screenWidth,
         maxWidth: context.screenWidth,
      ),
      child: SizedBox(
        width: context.screenWidth,
        child: Column(
          children: [
            30.boxHeight,
            30.boxHeight,
            30.boxHeight,
            SmallButton(
              width: context.screenWidth,
              onPressed: showDrawer,
              child: Text('bala asd blu'),
            ),
            20.boxHeight,
            SizedBox(
              width: context.screenWidth,
              child: Placeholder(
                strokeWidth: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
