part of '../task_sphere_app.dart';

class TaskSphereWrapper extends StatelessWidget {
  final Widget child;

  const TaskSphereWrapper({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Nested(
      children: [
        const ResponsivenessWrapper(
          designSize: Size(390, 844),
          useMediaQuery: true,
        ),
        VanillaNotifierHolder<ThemeVanilla>(
          notifier: ThemeVanilla(),
        ),
      ],
      child: Builder(
        builder: (context) {
          50.boxHeight;
          return child;
        },
      ),
    );
  }
}
