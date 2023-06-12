part of '../home_screen.dart';

class _HomeView extends StatelessWidget {
  final VoidCallback showDrawer;
  final ValueNotifier<double> drawerOffsetNotifier;

  const _HomeView({
    Key? key,
    required this.showDrawer,
    required this.drawerOffsetNotifier,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        65.boxHeight,
        Padding(
          padding: EdgeInsets.only(left: 18.w),
          child: _TopContents(
            drawerOffsetNotifier: drawerOffsetNotifier,
            showDrawer: showDrawer,
          ),
        ),
        43.boxHeight,
        const _ProgressiveAnalyticsWidget(),
        24.boxHeight,
        Divider(
          height: 1.h,
          thickness: 1.h,
          color: context.neutralColors.$400,
        ),
      ],
    );
  }
}
