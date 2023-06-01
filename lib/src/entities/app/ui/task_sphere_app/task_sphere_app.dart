import 'package:flutter/material.dart';
import 'package:task_sphere/src/entities/app/app_barrel.dart';

class TaskSphereApp extends StatelessWidget {
  const TaskSphereApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter.routerConfig,
    );
  }
}
