part of '../home_screen.dart';

class _Drawer extends StatelessWidget {
  const _Drawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 212.w,
      color: context.bgColors.$50,
      child: Material(
        child: const Placeholder(),
      ),
    );
  }
}
