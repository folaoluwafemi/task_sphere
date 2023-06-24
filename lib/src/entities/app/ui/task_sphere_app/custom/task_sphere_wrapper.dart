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
        VanillaNotifierHolder<ProgressiveAnalyticsVanilla>(
          createNotifier: () => ProgressiveAnalyticsVanilla()..initialize(),
        ),
      ],
      child: Builder(
        builder: (context) {
          return child;
        },
      ),
    );
  }
}
