part of '../task_sphere_app.dart';

class TaskSphereWrapper extends StatelessWidget {
  final Widget child;

  const TaskSphereWrapper({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(
        textScaleFactor: 1,
      ),
      child: Builder(
        builder: (context) {
          return child;
        },
      ),
    );
  }
}
